# Submission — Loop

## Links

- **Live app:** https://loop-transfers.serverpod.space/app/
- **Landing page (server-rendered, live numbers):** https://loop-transfers.serverpod.space/
- **Repository:** https://github.com/TusharTechs/loop-transfers
- **Android APK:** see the GitHub release (arm64 for most phones)
- **Demo video:** https://youtu.be/FdcLxQEm9Eg
- **Social posts:** [X](https://x.com/TusharA5649881/status/2110037023713304637) · [LinkedIn](https://lnkd.in/p/gDV8xncq) · [Bluesky](https://bsky.app/profile/techtush.bsky.social/post/3mxrg2lok2f23)

## Testing instructions for judges

No email needed — ten demo accounts are ready:
**`judge1@example.com` … `judge10@example.com`, password `LoopDemo-2026!`**

1. Open the live app → **Post your transfer request** → **Sign in** with a
   demo account (or sign up with your own email; Serverpod Cloud sends the code).
2. Tap **Try it in one tap** (a Primary Teacher in Pune who wants Nagpur, in
   the Sandbox) — or fill in the form yourself.
3. Within seconds a **3-way loop** appears on your dashboard. Open it: the two
   simulated colleagues accept live, one after the other, and the loop is
   drawn on the map. Accept your move.
4. The loop confirms: names and contacts are revealed, and you get a
   verification code plus **Joint application (PDF)** and **Verification page**
   buttons — what you would take to the transfer office.
5. **Live market** (no account needed): pick any exchange and watch loops form
   and close across India in real time.
6. **How it works → Loop Lab**: drag the sliders to run the real engine on a
   synthetic cadre and compare pairs only vs Loop.
7. On the dashboard, **Try the sandbox again** repeats the flow; **Decline** on
   a proposal shows the loop dissolving and the engine searching again.

All demo exchanges use clearly labelled simulated members. An automated
end-to-end check of the same flow: `cd loop_server && dart run tool/smoke.dart https://loop-transfers.api.serverpod.space/`

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

**Serverpod stack.** Models and ORM for 10 tables; a stateless compute endpoint (Loop Lab); PostGIS geography fields
with GiST indexes; transactions, `FOR UPDATE` row locks and advisory locks;
future calls for deadlines, debounced re-solves, simulated replies and a
recurring sweep (with an automatic in-process fallback where future calls are
unavailable, as on the Cloud Starter plan); typed streaming endpoints and
server events for the member feed and the live market map; email
authentication with server-only contact fields; serializable exceptions;
Relic web routes and templates for the landing page, verification pages and printable joint applications;
`withServerpod` integration tests on embedded Postgres; deployed on Serverpod
Cloud.

**Flutter app** (web, Android, iOS): editorial design system, animated loop
ring, custom-painted India map (Natural Earth, India point of view),
responsive layouts, light and dark themes.

**AI tools:** Product direction and decisions are by Tushar Agarwal. Claude
Code (Anthropic, Claude Opus 5.5) was used for research, architecture, code,
tests, debugging, deployment, documentation, the app icon, screenshots and the
demo video recording; Kokoro-82M (open-weight TTS) for the video voiceover;
Claude Sonnet sub-agents for background research and preparing the map and
district datasets; Serverpod's agent skills as API reference. No AI runs
inside the product — matching is a deterministic graph engine.

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
