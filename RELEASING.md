# Releasing

Every NineTailsFlip app is built and released by the same workflow,
[`.github/workflows/android.yml`](.github/workflows/android.yml). Each app's own
`.github/workflows/build.yml` calls it.

| When | What happens |
|---|---|
| Push to `main`, pull request | Unit tests, lint, and a debug APK, which you can download from the run's artifacts |
| Tag `v<versionName>` | The same, then a release build signed with the organization key, published as a GitHub Release with the APKs and an `update.json` |

The apps read `update.json` from their latest release once a day, through `nine-core/update`.
When there is a newer `versionCode`, they offer the update on their main screen. People can turn
this off in Settings → Updates.

## Once: the signing key

```bash
scripts/setup-release-signing.sh
```

This creates one release key for all apps in `~/NineTailsFlip-signing` and stores it as GitHub
Actions secrets. It also passes TG9's Telegram API credentials from `tg9/local.properties` to
the tg9 repository. **Back up that folder offline.** Android installs an update only if it is
signed with the same key, so losing the key means no installed copy of any of our apps can be
updated again.

## Each release

1. In the app, raise `versionCode` (by at least 1) and set `versionName` in
   `app/build.gradle.kts`.
2. Commit and push to `main`.
3. Tag and push the tag. The tag must be exactly `v` plus `versionName`:

   ```bash
   git tag v0.2.0 && git push origin v0.2.0
   ```

The workflow refuses a tag that doesn't match `versionName`. It also refuses to sign without
the release key, since a release signed with any other key couldn't update anyone's phone.
GitHub writes the release notes from the merged pull requests and commits, and the update screen
shows them.

TG9's first release builds TDLib (about 15 minutes). Later releases reuse it from the cache
until `third_party/td` or `scripts/build-tdlib.sh` changes.

## Installing the first time

There is nothing to update from yet, so the first install is by hand: download the APK from the
release, using `-arm64-v8a` for most keypad phones and `-armeabi-v7a` for older 32-bit ones, and
open it. After that, the app updates itself.

Builds from before the switch to `io.github.ninetailsflip.*`, and debug builds, have a different
id or key. Uninstall them first.
