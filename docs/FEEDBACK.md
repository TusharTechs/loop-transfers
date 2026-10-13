# Feedback for the Serverpod team

Collected while building Loop on Serverpod 4.0.4 (CLI 4.0.4, Flutter 3.47,
macOS arm64). Each item says what happened, why it hurt, and a concrete fix.

## Serverpod Cloud

1. **Starter plan + future calls fail silently.** The pricing page says
   "Future calls disabled" on Starter, but the Cloud docs, `serverpod cloud
   launch` and the server log say nothing. An app that schedules future calls
   deploys fine and then simply never runs them.
   *Suggestion:* have `launch`/`deploy` warn when the project defines
   `FutureCall`s and the plan disables them, and log one clear line at server
   start ("future call execution disabled by plan"). Documenting which env
   variable Cloud sets would let apps degrade gracefully (Loop now falls back
   to timers by checking `config.futureCall.enabled` /
   `futureCallExecutionEnabled`).

2. **PostGIS / pgvector availability on Cloud is not documented.** Serverpod 4
   advertises geography and vector types and the embedded Postgres ships both
   extensions, but the Cloud docs never say whether the managed database has
   them. A sentence in the database page would save a deploy-to-find-out.

## ORM and database

3. **`inSet` with a set literal fails at runtime on `id` columns.**
   `t.id.inSet({for (final s in seats) s.memberId})` compiles, but throws
   `type '_Set<int?>' is not a subtype of type 'Set<int>'` at runtime, because
   the literal is inferred from the column's nullable static type.
   *Suggestion:* accept `Iterable<T>` (copying into a set internally) or type
   `id` columns as non-nullable `ColumnInt`. Until then, a note in the
   database docs.

4. **`orderDescending` removal trips agents and old snippets.** Many examples
   and model knowledge still use `orderBy: ..., orderDescending: true`.
   The 4.0 breaking-changes page could list it explicitly, and an analyzer
   quick-fix to `.desc()` would help.

5. **`unsafeQuery` returns `numeric` as `String`.** `SUM(bigint)` yields
   `numeric`, which comes back as a String and crashes `as num` casts in
   production only. A short "Postgres → Dart type mapping" table in the raw SQL
   docs (and a recommendation to cast) would prevent it.

6. **`serverOnly` fields must be nullable — the error does not say why or
   what to do.** A hint like "server-only fields are omitted when sent to the
   client, so they must be nullable; consider a server-only model instead"
   would make the rule self-explanatory.

7. **`ServerpodRole` is not exported from `package:serverpod`**, although
   `pod.config.role` returns it, so checking the role needs a direct
   dependency on `serverpod_shared` or a `.name` comparison.

## Testing

8. **`withServerpod` endpoint calls bypass serialization and the WebSocket
   transport.** Our stream integration test passed while the real app had a
   (UI) bug, and serialization or transport issues in streaming methods can't
   be caught at all. An opt-in mode that routes calls through the generated
   client and the real WebSocket would make streams genuinely testable.

## Tooling, MCP and App Studio

9. **`.mcp.json` assumes `serverpod` and `dart` are on PATH.** When the CLI
   is installed by App Studio (into `~/Library/Application Support/Dart/...`)
   and Flutter lives elsewhere, the MCP servers fail with `ENOENT` in agents
   that do not inherit the user's shell PATH. Writing absolute paths into
   `.mcp.json` at create time, or a `serverpod doctor` check, would fix it.

10. **App Studio launched from Downloads stalls.** Run straight from the
    Downloads folder (macOS App Translocation), the first-run component
    install stopped after the CLI; moving the app to /Applications fixed it.
    Detecting translocation and asking the user to move the app would avoid
    the confusion.

11. **Debugging message channels is opaque.** When a live update does not
    arrive, there is no way to see which streams are open and which channels
    they listen to. Showing open method streams and `session.messages`
    subscriptions in Insights would make real-time features much easier to
    debug.

## Auth UI

12. **Email sign-up always requires a strong password.** For apps where users
    sign in rarely (like transfer requests), a code-only (passwordless) mode
    of `SignInWidget` would lower friction, and the widget's copy could make
    the password step clear up front.
