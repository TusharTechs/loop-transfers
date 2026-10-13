# Submission — Loop

## Links

- **Live app:** https://loop-transfers.serverpod.space/app/
- **Landing page (server-rendered, live numbers):** https://loop-transfers.serverpod.space/
- **Repository:** https://github.com/TusharTechs/loop-transfers
- **Android APK:** see the GitHub release (arm64 for most phones)
- **Demo video:** _(YouTube link)_

## Testing instructions for judges

1. Open the live app. The **Live market** tab works without an account:
   pick an exchange and watch loops light up on the map as the engine finds
   them and simulated members accept.
2. **My loop → Post your transfer request.** Sign up with any email you can
   read (Serverpod Cloud sends the verification code), choose a password,
   then enter a name and a phone or email.
3. Choose the **Sandbox** exchange, any current district (e.g. *Pune*), and a
   place you would move to (e.g. *Nagpur*). Submit.
4. Within a few seconds a **3-way loop** appears on your dashboard. Open it:
   the two simulated colleagues accept live, one after the other. Accept your
   move — the loop confirms, names and contacts are revealed, and you get a
   verification code.
5. Open `https://loop-transfers.serverpod.space/v/<code>` to see the public
   verification page a transfer office would use.
6. On the dashboard, **Try the sandbox again** repeats the flow; you can also
   try **Decline** to see the loop dissolve and the engine search again.

All demo exchanges use clearly labelled simulated members.

## Text description

**Loop finds the three- and four-way transfer chains that one-to-one portals
miss, and gets everyone in the chain to commit at once.**

Public-sector employees in India — teachers, nurses, police, postal staff —
can usually only change posting through a *mutual transfer*: they must find
someone in the same cadre where they want to go who wants to come where they
are. Official portals match pairs, and pairs are rare. Loop models every
request as a graph and finds the cycles: Pune → Nagpur → Mumbai → Pune solves
three families where no pair exists. On the demo markets Loop places 2.5–4×
more people than pairwise matching on the same requests, computed live on
every engine run.

**How it works.** Members post where they are and up to five ranked places
they would go (exact districts or "within 50 km"). A PostGIS spatial join
builds the "who would accept whom" graph inside Postgres. A pure-Dart engine
prunes dead ends, splits the graph into strongly connected components,
enumerates every 2–4 way cycle and packs non-overlapping loops that maximise
the *expected* number of people moved (a loop happens only if everyone
accepts). Proposals are a two-phase commit for humans: all seats are reserved
in one transaction with row locks (and an advisory lock per exchange), each
member sees their move and a deadline, answers stream live to everyone in the
loop, one decline releases everyone and is never proposed again, and silence
expires. Identities and contacts are revealed only when everyone has said yes,
along with a public verification page for the transfer office.

**Serverpod stack.** Models and ORM for 10 tables; PostGIS geography fields
with GiST indexes; transactions, `FOR UPDATE` row locks and advisory locks;
future calls for deadlines, debounced re-solves, simulated replies and a
recurring sweep (with an automatic in-process fallback where future calls are
unavailable, as on the Cloud Starter plan); typed streaming endpoints and
server events for the member feed and the live market map; email
authentication with server-only contact fields; serializable exceptions;
Relic web routes and templates for the landing page and verification pages;
`withServerpod` integration tests on embedded Postgres; deployed on Serverpod
Cloud.

**Flutter app** (web, Android, iOS): editorial design system, animated loop
ring, custom-painted India map (Natural Earth, India point of view),
responsive layouts, light and dark themes.

**AI tools:** _(to be completed)_

## Build and run

See the README: `cd loop_server && serverpod start` (Flutter 3.44.4+, Serverpod
CLI 4.0.4; no Docker). Tests: `dart test` in `loop_server`.

## Demo video script (≤ 2 minutes)

| Time | Show | Say |
|---|---|---|
| 0:00–0:12 | Welcome screen, story ring animating | "Priya teaches in Pune. Her husband works in Nagpur. To move, she needs a teacher in Nagpur who wants Pune. That person doesn't exist." |
| 0:12–0:25 | Ring closes | "But someone in Nagpur wants Mumbai, and someone in Mumbai wants Pune. That's a loop. Today's portals only match pairs — Loop finds loops." |
| 0:25–0:45 | Live market map, loops lighting up; Loops vs pairs card | "This is a live market. Every glowing ring is a loop the engine just found. On the same requests, Loop moves about three times more people than pair matching." |
| 0:45–1:10 | Sign in, Sandbox request Pune → Nagpur, dashboard | "Posting a request takes a minute. The engine runs on Serverpod — a PostGIS query builds the graph, a Dart engine finds the cycles." |
| 1:10–1:35 | Loop screen: colleagues accept live, tap Accept, reveal | "Everyone's seat is reserved in one transaction. Answers stream live. Nobody is revealed until everyone says yes — then contacts and a verification code appear." |
| 1:35–1:50 | Verification page | "The transfer office can verify the loop is genuine." |
| 1:50–2:00 | Landing page numbers | "Loop. Built with Serverpod, Flutter and PostGIS. Close the loop." |
