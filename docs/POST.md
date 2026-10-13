# Social posts for the Serverpod social media prize

Tag Serverpod: LinkedIn **@Serverpod**, X **@ServerpodDev**, Bluesky **@serverpod.dev**.
Attach `docs/demo/loop-demo.mp4` as a native video wherever possible.

## LinkedIn

Pairs are rare. Loops are everywhere. 🔁

A teacher in Pune wants to move to Nagpur to be with her family. The only way is a mutual transfer: someone in Nagpur, in her exact cadre, who wants Pune.

Nobody in Nagpur wants Pune. So she waits. Often for years.

But there's a teacher in Nagpur who wants Mumbai, and one in Mumbai who wants Pune. All three could move home tomorrow. Transfer portals only match pairs, so nobody ever sees it.

For the "Build Something Real" hackathon by Serverpod, I built Loop, which finds those loops.

How it works:
→ PostGIS builds a "who would accept whom" graph, using exact districts or "anywhere within 50 km"
→ A pure-Dart engine finds every 2-, 3- and 4-way cycle and picks the set that moves the most people. It's the same idea used to match kidney exchanges.
→ Every seat in a proposed loop is reserved in a single Postgres transaction, so no one can ever be in two loops at once
→ Answers stream live to everyone in the loop. One "no" releases everyone, and silence expires on a deadline.
→ Names and contacts stay hidden until everyone says yes. Then Loop generates the joint transfer application and a public page where the transfer office can verify that everyone agreed.

Does it matter? In the app's Loop Lab, the server builds a whole cadre and runs the real engine twice on the same people. In thin markets, allowing loops moves 3 to 5 times as many people as pairs alone.

Built end to end in Dart: Serverpod 4 (typed endpoints, streaming, future calls, server-rendered web pages, built-in auth, Serverpod Cloud) and one Flutter codebase for web, Android and iOS. Writing the server and the app in the same language, with a generated client between them, made it possible to go from idea to a deployed product quickly.

Try it with a demo account, no email needed. Post a request in one tap and watch a loop form and close in seconds. Links are in the first comment 👇

#Serverpod #Flutter #Dart #GovTech #BuildSomethingReal

### First comment (post it right after publishing)

▶ Live app: https://loop-transfers.serverpod.space/app/
🎬 1:50 demo: https://youtu.be/FdcLxQEm9Eg
💻 Code (MIT): https://github.com/TusharTechs/loop-transfers
📱 Android APK: https://github.com/TusharTechs/loop-transfers/releases/tag/v1.0.0

## X (thread, each post under 280 characters)

1/ (attach the video)

> Transfer portals in India only match pairs. Pairs are rare, so teachers, nurses and police wait years to move home.
>
> I built Loop: it finds 3- and 4-way swap loops and gets everyone to say yes at once.
>
> Built with @ServerpodDev + Flutter 🔁
> https://loop-transfers.serverpod.space/app/

2/

> How it works:
> • PostGIS builds the "who'd accept whom" graph
> • A Dart engine finds the cycles (same idea as kidney exchanges)
> • Every seat is locked in one Postgres transaction
> • Answers stream live, one "no" frees everyone
>
> Code (MIT): https://github.com/TusharTechs/loop-transfers

3/

> Try it with a demo account, no email needed. Post a request in one tap and watch a loop form and close in seconds.
>
> Full demo: https://youtu.be/FdcLxQEm9Eg
>
> #Serverpod #Flutter #Dart
