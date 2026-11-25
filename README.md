# .github

NineTailsFlip's organization profile, shared CI and community defaults.

[![License: GPL-3.0](https://img.shields.io/badge/license-GPL--3.0-blue)](LICENSE)

## What's here

| Path | What it is |
|---|---|
| `profile/README.md` | The page shown at <https://github.com/NineTailsFlip> |
| `.github/workflows/android.yml` | The workflow every app's `build.yml` calls: tests, lint and a debug APK on each push; a signed GitHub Release with an `update.json` for the apps' updater on each `v*` tag |
| `RELEASING.md` | How releases work, and the one-time signing setup |
| `scripts/setup-release-signing.sh` | Creates the organization's release key once and stores it as Actions secrets |
| `CONTRIBUTING.md`, `SECURITY.md`, issue forms, pull request template | Defaults for every repository in the organization that has none of its own |
| `assets/` | The logo (`logo.svg`, `logo.png` for the avatar) and the profile banner |

## Usage

An app's `.github/workflows/build.yml`:

```yaml
jobs:
  android:
    uses: NineTailsFlip/.github/.github/workflows/android.yml@main
    with:
      app: l9          # the app's short name: APK names and update.json use it
    secrets: inherit
```

Then push a `v<versionName>` tag to release. See [RELEASING.md](RELEASING.md).

## Contributing

Issues here are for requests to adapt an everyday app for keys
([request one](https://github.com/NineTailsFlip/.github/issues/new?template=app_request.yml)).
Bugs go to each app's repository. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

GPL-3.0 — see [LICENSE](LICENSE).
