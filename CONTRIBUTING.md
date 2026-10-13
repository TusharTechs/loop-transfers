# Contributing to Loop

Thanks for helping people close their loops.

## Getting set up

Follow [Run it locally](README.md#run-it-locally). You need Flutter 3.44.4+ and
the Serverpod CLI 4.0.4; no Docker.

## Making a change

1. Create a branch from `main`.
2. Models live in `loop_server/lib/src/loop/models/*.spy.yaml`. After changing
   them run `serverpod generate`, and `serverpod create-migration` if a table
   changed. Never edit `loop_client/` or `loop_server/lib/src/generated/`.
3. The loop engine (`loop_server/lib/src/engine/`) is pure Dart: add a unit test
   in `loop_server/test/unit/` for any change to it.
4. Server behaviour is tested with `withServerpod` in
   `loop_server/test/integration/` against an embedded PostgreSQL.
5. Before opening a pull request:

   ```bash
   cd loop_server && dart format . && dart analyze && dart test
   cd ../loop_flutter && dart format lib && flutter analyze
   ```

6. Describe the user-visible change in the pull request, with a screenshot for
   UI changes.

## Principles

- **Privacy first.** Nothing that identifies a member leaves the server until
  every member of their loop has accepted.
- **All or nothing.** Loop state changes happen in one database transaction.
- **Honest numbers.** Comparisons with pairwise matching are computed, never
  assumed. Simulated data is always labelled.

By contributing you agree that your contributions are licensed under the
[MIT licence](LICENSE).
