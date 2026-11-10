# NBA 2K26 / 2K27 Cronus Zen God Pack

<img src="banner-v6.png" alt="NBA 2K26 / 2K27 Cronus Zen God Pack" width="100%">

Open GPC script collection for Cronus Zen. NBA 2K26 and 2K27 first, plus COD,
Siege, Fortnite, Apex and Rust sets that share the same timing engine.

**77 scripts.** All plain text, all editable, all compiled in Zen Studio.

[SLEM CV](#slem-cv) · [Setup](#setup) · [Scripts](#whats-in-the-pack) ·
[Full index](SCRIPTS.md) · [Troubleshooting](SUPPORT.md) ·
[Changelog](CHANGELOG.md) · [Contributing](CONTRIBUTING.md)

---

## SLEM CV

**SLEM CV is the app.** Everything in `scripts/` is the script library — CV is
the program that actually reads your shot meter and releases the button for
you. It runs on a PC and drives the controller for whatever platform you're
playing on. Nothing gets installed on your console.

Two ways to use it:

| | What it is | What you need |
|---|---|---|
| **PC** | CV runs on the same PC as the game | Steam copy of 2K |
| **Console** | CV watches your PS5 or Xbox through a stream on the PC | Ethernet on both ends, plus a free capture app |

### How it reads the shot

CV looks at the game window on your screen, finds the shot meter, and lets go
at the moment the meter fills. No capture card, no console modification, no
injection into the game process — it watches pixels and plays your controller.

That's also the honest limit of it. Anything that reads your screen can
desync if the picture is late, which is why the guides make such a point about
Ethernet and turning Game Bar off.

### Platform support

| Platform | How it sees the game | Setup guide |
|---|---|---|
| **PC** | The game window itself | [`SLEM-CV-PC-Setup.pdf`](SLEM-CV/SLEM-CV-PC-Setup.pdf) |
| **PlayStation** | `chiaki-ng` stream — *not* PS Remote Play | [`SLEM-CV-PlayStation-Setup.pdf`](SLEM-CV/SLEM-CV-PlayStation-Setup.pdf) |
| **Xbox** | Xbox app remote play | [`SLEM-CV-Xbox-Setup.pdf`](SLEM-CV/SLEM-CV-Xbox-Setup.pdf) |

On console it does **not** touch the console. It watches the stream on the PC
and plays the PC controller, which the console sees as a normal pad.

### The first-run setup

`Start Setup.bat` in `SLEM-CV/` installs the controller bridge — the piece that
hides your real pad from the game and hands it a virtual one instead. Without
it CV opens, draws its overlay, and reads nothing.

It's a one-time job per PC. Re-run it after a Windows feature update; those
occasionally reset the driver registration.

The bridge uses two open-source components, both linked from the guides:

- **ViGEmBus** — the virtual controller the game talks to
- **HidHide** — hides the physical pad so the game can't see two

### Setup wizard

Once you're past the bridge, CV's own Setup window walks you through it. Each
step checks something real and turns green when it passes — controller
visible, stream up, shot meter found, HDR off, Game Bar off. A red step tells
you what to fix instead of failing silently later.

Only the **Test** step asks anything of you: shoot ten times yourself and let go
on your own timing, then press Next.

### Why controllers matter

CV has to hide your real controller from the game. That only works for:

- PlayStation pad — DualSense or DualShock 4, USB or Bluetooth
- Xbox pad — **Bluetooth only**

Xbox over USB can't be hidden; Windows drives it as XInput where no wrapper can
intercept it, so the game sees both pads and fights your thumb. Same reason
there's no Cronus Zen or Titan Two in the chain — the pad goes straight to the
PC and CV plays it directly.

### A word on detection

On PC, 2K's anti-cheat can see programs running on the same machine, and a PC
account can be banned or suspended with no console in between. CV doesn't
modify the game — it reads your screen and plays your controller — but nobody
can promise that's undetectable forever. Console is the safer side because
nothing at all runs on the console.

Use it knowing that. No 100% green guarantee, no ban guarantee, and results
depend on your PC and your setup.

### Version

CV is on **v6**. The guides in `guides/` cover the script side (V2 through V5);
the three `SLEM-CV-*-Setup.pdf` files are the app side and are the ones to read
first.

CV is closed-source and free. The scripts in this repo are the open half.

---

## Setup

Extract the ZIP somewhere permanent — Desktop or Documents. Not inside the
archive, not on a network drive.

### 1. Run the setup

Open `SLEM-CV/` and run:

```
Start Setup.bat
```

If Windows asks whether to run it, choose **Run**. This is the controller
bridge described [above](#the-first-run-setup) — one time per PC.

### 2. Read your platform guide

In `SLEM-CV/`:

| Platform | Guide |
|---|---|
| PC | `SLEM-CV-PC-Setup.pdf` |
| PlayStation | `SLEM-CV-PlayStation-Setup.pdf` |
| Xbox | `SLEM-CV-Xbox-Setup.pdf` |

Controller rules and shot-meter settings live in there. Getting them wrong is
the second most common reason nothing works.

### 3. Load scripts

1. Zen Studio → File → Open → `scripts/<your game>/`
2. Pick a `.gpc`, press **F7** to compile
3. Zen connected by USB → drag the compiled script to a slot
4. Save

---

## What's in the pack

| Game | Scripts | Start with |
|---|---|---|
| NBA 2K27 | 37 | `SLEM-V4-FIXED.gpc` |
| Rainbow Six Siege | 12 | newest `MDM_*_V2_FIXED` |
| Call of Duty | 10 | `GhostV3.gpc` |
| Fortnite | 6 | `Bull_v5_NEW.gpc` |
| Apex Legends | 5 | `Highwater_V6.0.gpc` |
| SLEM Originals | 5 | `SLEM-V5.gpc` |
| Rust | 2 | `MDM_RUST_V3.gpc` |

Full listing with file sizes: [`SCRIPTS.md`](SCRIPTS.md)

### Guides

- [`Avenged_MVP_NBA_2K27_v1.04_Full_Guide_Detailed.txt`](Avenged_MVP_NBA_2K27_v1.04_Full_Guide_Detailed.txt) —
  build-by-build shot timing, the long version
- [`nba-2k27-swish-labs-v6-instructions.txt`](nba-2k27-swish-labs-v6-instructions.txt)
- `guides/` — SLEM V2 through V5 version guides

---

## How the timing works

Each script holds its own numbers in the `define` block at the top:

```c
define TIMING_BASE   = 38;    // 34-42, lower = earlier release
define HOLD_DURATION = 142;   // 120-160
define LATENCY       = 12;    // your display lag in ms
```

`TIMING_BASE` matters most and drifts after a game patch. If a script starts
feeling early or late, move that by 1–2 before touching anything else.

`LATENCY` is your display, not the script. TV in game mode is ~10, a monitor is
~5, anything through a capture card is 30+.

### Modes (2K scripts)

Three shooting modes, one active at a time:

- **TEMPO** — you time the release, the script handles the flick
- **GREEN** — fully automatic, script holds the button
- **QS GREEN** — same as GREEN but stops you first

Menu is **LT + START**. Full navigation in `guides/SLEM-V5-Guide.pdf`.

---

## Requirements

- **Cronus Zen** with current firmware, Zen Studio installed
- **Controller:** PlayStation pad (DualSense/DualShock 4) on USB or Bluetooth, or
  an Xbox pad over **Bluetooth**. A wired Xbox pad can't be hidden from the game
  and the script will fight your thumb
- **Network:** wired, both ends. Wi-Fi jitter isn't something tuning absorbs

---

## Support

[`SUPPORT.md`](SUPPORT.md) covers the five problems that account for almost
everything: controller not seen, shots early or late, wrong shot meter settings,
controller compatibility, and Zen Studio not detecting the device.

Discord: `discord.gg/slem`

---

## Contributing

PRs welcome — new scripts, timing corrections, guide fixes. Read
[`CONTRIBUTING.md`](CONTRIBUTING.md) first; it's short and explains why
re-uploads get closed.

---

## License

MIT — see [`LICENSE`](LICENSE). Script authorship for the third-party sets sits
with their original authors; they're mirrored here because the Zen community has
always shared timings.