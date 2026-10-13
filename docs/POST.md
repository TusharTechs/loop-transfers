# Draft post for the Best Hackathon Post prize

*(For LinkedIn, X or dev.to — edit freely before publishing. Attach `docs/demo/loop-highlight.gif` or the demo video.)*

---

**Pairs are rare. Loops are everywhere.** 🔁

In India, a teacher, nurse or police constable who wants to move closer to
family usually has one option: a *mutual transfer*. You need someone in your
cadre, posted where you want to go, who wants exactly your place. Official
portals match **pairs** — and pairs are rare. People wait years.

But often there is a **loop**: a teacher in Pune wants Nagpur, one in Nagpur
wants Mumbai, one in Mumbai wants Pune. Nobody can see it. So for the
#Serverpod "Build Something Real" hackathon I built **Loop**, which does.

🧠 **How it works**
- A PostGIS spatial join builds the "who would accept whom" graph (exact
  districts or "anywhere within 50 km").
- A pure-Dart engine finds strongly connected components, enumerates 2-, 3-
  and 4-way cycles and picks the set that moves the most people *in
  expectation* — the same idea behind kidney exchanges (Nobel 2012).
- Everyone in a loop is reserved in one Postgres transaction; answers stream
  live; one "no" releases everyone; a deadline (future call) expires silence.
- Names and contacts are revealed only when everyone has said yes — with a
  verification page and a printable joint application for the transfer office.

📊 **Does it matter?** On the same requests, Loop places 2–5× more people than
pair matching in thin markets — try the **Loop Lab** in the app and move the
sliders yourself.

🛠️ **Built with** Serverpod 4 (typed endpoints, streaming, future calls,
Relic web pages, embedded Postgres + PostGIS for dev, Serverpod Cloud) and
Flutter (web, Android, iOS). Full-stack hot reload made iterating on the
engine and the UI genuinely fun.

▶️ Try it (demo accounts, no email needed): https://loop-transfers.serverpod.space/app/
💻 Code: https://github.com/TusharTechs/loop-transfers

#Flutter #Dart #Serverpod #BuildSomethingReal #GovTech
