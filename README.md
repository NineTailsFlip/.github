# .github

NineTailsFlip's organization profile and defaults:

- `profile/README.md` is the page shown at <https://github.com/NineTailsFlip>.
- `assets/` holds the logo (`logo.svg`, plus `logo.png` for the avatar) and the profile banner.
- `CONTRIBUTING.md`, `SECURITY.md`, the issue forms and the pull request template apply to every
  repository in the organization that doesn't have its own.
- `.github/workflows/android.yml` builds every app: tests, lint and a debug APK on each push,
  and a signed GitHub Release with an `update.json` for the apps' updater on each `v*` tag. See
  [RELEASING.md](RELEASING.md). `scripts/setup-release-signing.sh` creates the signing key once.
- Issues here are for requests to adapt an app for keys. Bugs go to each app's repository.
