# Contributing to NineTailsFlip

Thanks for helping make everyday apps work on keypad phones. This applies to every repository in
the organization unless a repository says otherwise.

## The rules our apps follow

1. **Everything works with keys.** Up/Down move, OK acts, Back goes back, `*` opens the numbered
   menu (hold `*` for Settings), and `#` does the screen's obvious second thing. A feature that
   needs a tap or a swipe is not done.
2. **The hint bar tells the truth.** If you change what a key does on a screen, change that
   screen's hint bar and the key map in Settings → About → Key mapping.
3. **One column of plain text on black**, in the Nine suite's palette and spacing. Use what
   `nine-core` already provides (`RowListView`, `MenuSheet`, `HintBar`, `PermissionScreen`...)
   rather than building new widgets.
4. **Typing goes through the phone's own T9.** Watch for keys the input method takes before the
   screen sees them (OK, `*`, `#`). TG9's `KeyEditText` shows the way around it.
5. **Be careful with data, storage and battery.** Ask before big downloads, and never keep a
   connection open unless the user turned it on.
6. **Nothing destructive without Android's own confirmation**, such as MediaStore's trash and
   delete requests.

## Code

- Kotlin, Android 14+ (minSdk 34), with no AndroidX and no coroutines, like the Nine suite. If
  you need a new dependency, say why in the PR.
- `nine-core/core` and `nine-core/contacts` are the Nine suite's modules and stay
  **byte-for-byte unchanged**, so new versions can be copied over them. Shared code of our own
  goes in `nine-core/kit`.
- In the forks (L9, C9, P9, M9), keep our changes small and on top of upstream, and take
  upstream's changes with `scripts/sync-upstream.sh`. Anything that would help the official
  apps too is worth offering upstream: <https://git.sr.ht/~timofurrer/nine>.
- Lint warnings fail the build. Keep it that way.
- Put logic that doesn't need Android in pure functions and unit-test it
  (`./gradlew testDebugUnitTest`).
- UI text is English and built in code, as in every Nine app.

## Pull requests

- Keep each PR to one thing, and describe what changes for someone holding the phone.
- Say which phone you tried it on. Keypads and their input methods differ, and many bugs only
  show up on hardware.
- If you changed `nine-core`, land that PR first. Then bump the submodule in each app in its own
  commit.

## Issues

- **Bugs:** open them in the app's repository. Please include the phone model, the Android
  version, and the keys you pressed.
- **Requests for an app adapted to keys:** use the
  [app request form](https://github.com/NineTailsFlip/.github/issues/new?template=app_request.yml).

By contributing, you agree that your work is licensed under GPL-3.0-or-later, like the rest of
the code.
