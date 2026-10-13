# Loop — close the loop on mutual transfers

**Loop finds the three- and four-way transfer chains that one-to-one portals
miss, and gets everyone in the chain to commit at once — before anyone's
posting changes.**

Built for *Build Something Real: The Serverpod Hackathon* with Serverpod 4,
Flutter (web, Android, iOS) and PostgreSQL + PostGIS.

> **Try it:** open the app, sign up with your email, pick the **Sandbox**
> exchange, post a request — simulated colleagues complete a loop with you and
> answer within seconds. The **Live market** tab works without signing in.

---

## The problem

Millions of public-sector employees in India — teachers, nurses, police
constables, postal staff — can only change their posting through a
**mutual transfer**: they must find someone in the same cadre who sits where
they want to go *and* wants to come where they are. State portals match
**pairs** only (e.g. Bihar's e-Shiksha Kosh, Assam's Swagat Satirtha, whose
first round alone moved 9,004 employees).

Pairs are rare. A teacher in Pune whose spouse works in Nagpur can wait years,
because nobody in Nagpur wants Pune. But a teacher in Nagpur may want Mumbai,
and a teacher in Mumbai may want Pune. That **3-way loop** solves three
families at once — and today nobody can see it.

The same structure powers kidney paired donation, where cycle exchanges
(Roth & Shapley, Nobel 2012) dramatically increased matches. Loop brings it to
people who need to trade places.

## What Loop does

1. **You post a request** in your *exchange* (same cadre and post): where you
   are posted, and up to five places you would move to — an exact district or
   "anywhere within 50 km of X".
2. **The engine searches every loop.** Requests become a directed graph (an
   arrow from you to everyone posted where you want to go). Loop finds all
   2-, 3- and 4-way cycles and picks the set of non-overlapping loops that
   moves the most people *in expectation*.
3. **Everyone commits together.** All seats in a loop are reserved at once.
   Each person sees their move and a deadline; answers appear live for
   everyone in the loop. One decline releases everyone (and that move is never
   proposed again); silence expires and pauses the silent request.
4. **Then you meet.** Only when every person has accepted are names and
   contacts revealed — with a verification code that the transfer office can
   check on a public page.

On the simulated demo markets Loop consistently places **2.5–4× more people
than pairwise matching on the same requests** (the comparison is computed live
on every engine run and shown on the map and the landing page).

## Screens

| | |
|---|---|
| **Welcome** — the Pune → Nagpur → Mumbai story, animated | **Live market** — India map, demand flows, loops lighting up as they form and close |
| **Request** — exchange, posting, ranked wishes with radius | **Dashboard** — live loop card, demand stats ("7 colleagues want your district") |
| **Loop** — ring of seats, live answers, countdown, reveal on confirm | **Verification page** — server-rendered proof that everyone agreed |

## How Serverpod is used

Loop is not a CRUD app behind a static page — the server *is* the product.

| Serverpod feature | Where | What it does in Loop |
|---|---|---|
| **Models + ORM** (`*.spy.yaml`) | `loop_server/lib/src/loop/models/` | 9 tables (place, exchange, member, listing, wish, swap_loop, loop_seat, declined_edge, loop_event, solver_run) plus typed views and stream messages |
| **PostGIS** (`GeographyPoint`, GiST indexes) | `services/edges.dart` | The "who would accept whom" graph is built in **one spatial join** using `ST_DWithin` on geography for radius wishes |
| **Transactions, row locks, advisory locks** | `services/loop_service.dart` | Propose / accept / decline / expire are single transactions with `FOR UPDATE` row locks; `pg_try_advisory_xact_lock` guarantees one engine run per exchange — a listing can never be in two live loops |
| **Future calls** (durable, recurring) | `loop_future_calls.dart`, `services/jobs.dart` | Loop deadlines, debounced re-solves, simulated replies and a recurring sweep. Falls back to in-process timers where future calls are unavailable (e.g. Cloud Starter) — the database stays the source of truth |
| **Streaming endpoints + server events** | `endpoints/*`, `session.messages` | `loop.watch()` pushes changes to each member; `exchange.watch()` pushes an anonymised market feed to the live map |
| **Authentication** (`serverpod_auth_idp`, email) | `server.dart`, `member_context.dart` | Email sign-up; every member endpoint `requireLogin`; contacts are `serverOnly` fields revealed only in confirmed loops |
| **Serializable exceptions** | `loop_exception.spy.yaml` | Typed errors (`notAllowed`, `invalidState`, …) surfaced as friendly messages in the app |
| **Web server (Relic) + templates** | `lib/src/web/routes/loop_pages.dart` | Server-rendered landing page with live totals and `/v/<code>` loop verification for transfer offices; also serves the Flutter web app |
| **Testing** (`withServerpod`, embedded Postgres) | `loop_server/test/` | Engine unit tests (incl. randomized checks against brute-force validity) and integration tests for the whole lifecycle, PostGIS radius matching, privacy, idempotency and double-solve safety |
| **Serverpod Cloud** | `scloud.yaml` | Hosting for API, web, database and auth email |

## The engine

`loop_server/lib/src/engine/` is pure Dart, independent of the server:

1. **Prune** nodes with no in- or out-edges (they can never be on a cycle).
2. **Tarjan's strongly connected components** (iterative) — cycles never
   cross components.
3. **Bounded enumeration** of simple cycles up to the exchange's maximum loop
   size, each found exactly once (rooted at its smallest node).
4. **Scoring by expected people moved**: a loop of *k* happens only if all *k*
   accept, so `score = k · p^k · (1 + preference)`. This naturally prefers two
   robust pairs over one fragile 4-loop covering the same people, while still
   finding the long loops pairs can never see.
5. **Packing** non-overlapping loops: greedy, then local improvement that
   drops a chosen loop and refills its members with an exact branch-and-bound
   search over the loops touching them.
6. **Pairwise baseline** on the same graph, so every run reports how many
   people a pairs-only portal would have matched.

A random 20,000-person market (60,000 wishes) solves in about 60 ms on a
laptop — run `dart run tool/bench.dart` in `loop_server`.

## Privacy by design

- Before confirmation, partners appear only as "Primary Teacher · Nagpur".
- Who declined is never revealed — not even inside the loop.
- Contact details are server-only fields, sent only to members of a loop that
  everyone has accepted.
- The public verification page shows first names with an initial, posts and
  moves — no contact details.

## Demo data, honestly labelled

Real exchanges start empty, so Loop ships **simulated markets** for four
cadres (Maharashtra ZP teachers, Karnataka staff nurses, UP police constables,
India Post postal assistants) plus a **Sandbox**. They are labelled
"simulated members" everywhere. Simulated members answer proposals by
themselves; in the Sandbox they answer within seconds, and when you post a
request Loop adds simulated colleagues that close a 3-way loop with you, so
the whole flow can be tried in under a minute. Real people are always given
priority over simulated ones by the engine.

## Run it locally

Prerequisites: **Flutter 3.44.4+** (Dart 3.12.2+) and the Serverpod CLI 4.0.4
(`dart install serverpod_cli`). No Docker — Serverpod 4 runs an embedded
PostgreSQL with PostGIS.

```bash
git clone <this repo> loop && cd loop
cd loop_server
serverpod start          # server, database and the Flutter web app, with hot reload
```

Or step by step:

```bash
cd loop_server
serverpod run flutter_build                 # builds the Flutter web app into web/app
dart run bin/main.dart --apply-migrations   # API :8080, web :8082
```

Open <http://localhost:8082/app/> (app) and <http://localhost:8082/> (landing).
In development the email sign-up code is printed in the server log.

On first start the server seeds 763 Indian districts, the exchanges and the
simulated markets.

**Tests** (no Docker needed):

```bash
cd loop_server && dart test
```

**Mobile:** `cd loop_flutter && flutter run --dart-define=SERVER_URL=https://<your-server>/`

## Project layout

```
loop_server/   Serverpod server: engine, models, endpoints, future calls, web pages, tests
loop_client/   Generated client (do not edit)
loop_flutter/  Flutter app (web, Android, iOS)
docs/          Design notes and data sources
```

## Roadmap

- Shift-swap exchanges for hospitals (same engine, time slots instead of places)
- Hindi, Marathi and Kannada UI
- Integration with state transfer portals (submit the joint application)
- Employer verification of cadre and posting

## Data and licences

District coordinates © GeoNames (geonames.org), CC BY 4.0. Map outlines:
Natural Earth (public domain), India point of view. See
[docs/DATA_SOURCES.md](docs/DATA_SOURCES.md).
