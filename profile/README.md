<p align="center">
  <img src="https://raw.githubusercontent.com/NineTailsFlip/.github/main/assets/banner.svg" alt="NineTailsFlip: everyday apps for phones with a D-pad and a keypad. No touchscreen needed." width="100%">
</p>

We make everyday Android apps work on **phones with a D-pad and a number pad instead of a
touchscreen**. That means a messenger, a gallery, and the other things you reach for every day,
each one rebuilt so that every action is a key press away.

## Apps

| | App | What it is | Status |
|---|---|---|---|
| 💬 | **[TG9](https://github.com/NineTailsFlip/tg9)** | Telegram on 9 keys, an unofficial client built on [TDLib](https://github.com/tdlib/td). Chats, voice messages, photos and videos, notifications without Google push. | early, 0.1 |
| 🖼 | **[G9](https://github.com/NineTailsFlip/g9)** | Gallery on 9 keys: photos and videos by day and by folder, zoom, video playback, share, trash. | new, 0.1 |
| 🧩 | **[nine-core](https://github.com/NineTailsFlip/nine-core)** | The shared code: the Nine suite's `core` and `contacts` modules, plus our MediaStore gallery kit. | library |

### The Nine suite, forked

Our forks of Timo Furrer's [Nine](https://nine.furrer.life) apps. Each one keeps upstream's full
history and can merge upstream changes with one script.

| | App | What it is |
|---|---|---|
| 🏠 | **[L9](https://github.com/NineTailsFlip/l9)** | Launcher: the number keys launch your apps. |
| 📅 | **[C9](https://github.com/NineTailsFlip/c9)** | Calendars and contacts. |
| 📞 | **[P9](https://github.com/NineTailsFlip/p9)** | Phone: the dialer and calls. |
| ✉️ | **[M9](https://github.com/NineTailsFlip/m9)** | Messages: SMS conversations. |

There are no release APKs of our own yet. Each repository explains how to build it. The official
Nine builds are on [Nine's F-Droid repository](https://nine.furrer.life).

## How our apps feel

- **Keys first, always.** Up/Down move, OK acts, Back goes back. `*` opens a numbered menu where
  a digit picks an item, and `#` does the obvious second thing. Nothing needs a tap or a swipe.
- **One column of plain text on black.** It is easy to read on a 2.4″ screen. A dim hint bar at
  the bottom always says which keys matter right now.
- **The phone's own T9** for typing, never an on-screen keyboard.
- **Light on the phone.** Downloads are small and big files ask first. No Google Play Services
  are required, and nothing is shared unless you ask for it.
- **The same keys in every app**, so learning one means knowing all of them.

## Phones

Android 14 or newer with a D-pad, an OK key and a number pad. Our apps run without a
touchscreen and without Google services.

## Built on

- **[Nine](https://git.sr.ht/~timofurrer/nine)** by Timo Furrer (L9, C9, P9, M9): the keypad UI
  our apps share and the apps we fork, used under GPL-3.0. Our apps are GPL-3.0-or-later too.
- **[TDLib](https://github.com/tdlib/td)**, Telegram's own client library. TG9 is not made by
  Telegram and is not affiliated with it.

## Get involved

- **Something broken?** Open an issue in that app's repository. The form asks for your phone
  model, because keypads differ.
- **Want an everyday app adapted for keys?**
  [Request it here](https://github.com/NineTailsFlip/.github/issues/new?template=app_request.yml).
- **Want to code?** Read [CONTRIBUTING](https://github.com/NineTailsFlip/.github/blob/main/CONTRIBUTING.md).
