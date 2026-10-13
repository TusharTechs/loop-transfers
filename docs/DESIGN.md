# Loop — design

> Close the loop. Loop finds the multi-way swap chains that one-to-one
> mutual-transfer portals cannot see, and gets every person in the chain to
> commit — atomically, with a deadline — before anyone's posting changes.

## 1. Problem

Millions of public-sector employees in India (teachers, nurses, police,
clerks, postal staff) can only move between postings through a **mutual
transfer**: you must find someone in the same cadre who sits where you want
to go *and* wants to come where you are. State portals (e.g. Bihar
e-Shiksha Kosh, Assam Swagat Satirtha) only match **pairs**. Assam's first
round alone moved 9,004 employees this way.

Pairwise matching leaves most people stuck. If a teacher in Pune wants
Nagpur, nobody in Nagpur may want Pune — but someone in Nagpur may want
Mumbai and someone in Mumbai may want Pune. That 3-way loop solves all three
families, and today it is invisible.

This is the same structure as kidney paired donation, where cycle and chain
exchanges (Roth, Shapley — Nobel 2012) dramatically increase matches.

## 2. Users

- **Employee** (primary): has a current posting, wants to move to one of a few
  places (a district, or "anywhere within N km of X"). Wants privacy — does
  not want colleagues to know they are looking.
- **Transfer officer** (secondary): receives the joint application and needs
  to verify it is genuine and that every party agreed.

## 3. Core concepts

| Concept | Meaning |
|---|---|
| Exchange | A pool where swaps are legal: same cadre / post / grade (e.g. "Maharashtra ZP Primary Teachers"). Has `maxLoopSize` and `acceptWindow`. |
| Place | A district with a PostGIS point (GeoNames centroid). |
| Listing | One member's request in one exchange: current place + post + ranked wishes. |
| Wish | "Exactly district X" or "anywhere within R km of X". Ranked. |
| Edge A→B | A would accept B's posting (B's place satisfies one of A's wishes). |
| Loop | A directed cycle A→B→…→A. Everyone takes the next person's post. |
| Seat | A member's place in a loop + their response. |

## 4. The engine

### 4.1 Edge building (PostGIS, in the database)
One SQL query per exchange joins `wish × listing × place` with
`ST_DWithin(wish.point, place.point, radius)` (or exact place match), excludes
declined edges, and returns `(from, to, wishRank, km)`. Spatial work stays in
Postgres where it is indexed.

### 4.2 Cycle search (pure Dart, `lib/src/engine/`)
1. **Prune**: repeatedly drop nodes with no in- or out-edges — they can never
   be on a cycle.
2. **Strongly connected components** (Tarjan) — cycles never cross SCCs.
3. **Bounded enumeration** of simple cycles up to `maxLoopSize` inside each
   SCC, canonical (start node is the smallest id) so each cycle is found once.
   Capped to keep worst cases bounded.
4. **Scoring**: expected people moved. A loop of size *k* only happens if all
   *k* accept, so `score = k · p^k + preference bonus` (p≈0.85, bonus from wish
   rank and distance). Short loops are favoured when they cover the same
   people.
5. **Packing**: choose a set of vertex-disjoint cycles maximising total score
   (greedy by score, then an improvement pass that swaps one chosen cycle for
   two disjoint ones when that serves more people).
6. **Baseline**: the same graph solved with 2-cycles only, so the app can show
   "pairwise: 11 people, Loop: 47 people" on live data.

### 4.3 Commit protocol ("two-phase commit for humans")
- **Propose** (one DB transaction, under a per-exchange advisory lock):
  re-check every listing is still `active` with `SELECT … FOR UPDATE`, flip them
  to `reserved`, insert the loop + seats, schedule a durable **deadline future
  call**. A listing can be in at most one live loop.
- **Respond**: row-lock the loop; record accept/decline.
  - all accepted → `confirmed`; listings → `matched`; contact details are
    revealed only now; a public verification code is minted.
  - any decline → `declined`; the decliner's edge is remembered so it is never
    proposed again; everyone else is released and the exchange is re-solved.
- **Deadline** (future call): still pending → `expired`; silent members are
  paused (so they stop blocking others), the rest are released, re-solve.
- **Re-solve triggers**: a debounced future call after any listing change, plus
  a recurring sweep. Every state change is pushed live.

### 4.4 Real time
`session.messages` channels:
- `member:<id>` — loop proposals and seat updates for one member.
- `exchange:<id>` — anonymised market pulse (new listings, loops formed,
  confirmed) for the live map.

Streaming endpoints turn these into typed streams for the app.

## 5. Privacy
- Other members are shown as "Teacher · Nagpur" until a loop is confirmed by
  everyone; only then are names and contacts revealed, and only to that loop.
- Declines are never shown as "X declined you" — only "the loop dissolved".

## 6. Surfaces
- **Flutter app** (web, Android, iOS): onboarding, my listing, loop proposals
  with live acceptances and countdown, confirmed loop with contacts and
  next steps, live market map of India with loops lighting up.
- **Server-rendered web** (Relic): landing page with live stats, and
  `/v/<code>` public verification page for transfer officers.

## 7. Demo / sandbox
A clearly labelled **Sandbox exchange** filled with simulated members whose
bots respond after a few seconds (durable delayed future calls). A judge can
sign up, post a listing, and watch a loop form and confirm in under a minute.
All other demo exchanges are marked "simulated members".

## 8. Data model (tables)
`place`, `exchange`, `member`, `listing`, `wish`, `swap_loop`, `loop_seat`,
`declined_edge`, `loop_event` (audit timeline).

## 9. Non-goals (v1)
Official portal integration, document upload/verification of employment,
SMS notifications, multi-language UI (planned: Hindi, Marathi, Kannada).
