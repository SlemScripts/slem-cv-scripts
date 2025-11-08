# Support

Read the guide for your platform in `SLEM-CV/` before anything else. Nine out of
ten questions are answered there.

---

## Common issues

### The app doesn't see my controller

You didn't run the setup.

Go to `SLEM-CV/` and run `Start Setup.bat`. It installs the controller bridge
that hides your physical pad from the game and gives it a virtual one instead.
Without it the app launches, shows the overlay, and reads nothing.

Run it once per PC. Re-run it after a Windows feature update — those occasionally
reset the driver registration.

### Shots are consistently early or late

Your shot meter settings don't match what the app reads.

In 2K, Settings → Controller Settings:

| Setting | Must be |
|---|---|
| Shot meter | ON |
| Shot meter type | Arrow 2 |
| Shot meter size | Large |
| Shot meter position | To the side of the player |
| Shot feedback | All shots |

The feedback setting matters more than it looks — the app needs the TIMING box
after every shot to measure from. With it off it has nothing to read.

### Which controller can I use?

**Works:** PlayStation pad (DualSense or DualShock 4) over USB or Bluetooth.
Xbox pad over **Bluetooth**.

**Doesn't work:** Xbox pad on a USB cable. Windows presents a wired Xbox pad as
XInput and it can't be hidden from the game, so the game sees two pads and your
own thumb on the button fights the script.

### Wireless latency

Ethernet, both ends. Wi-Fi adds 20–80 ms of jitter that no tuning will absorb.
If you're on Wi-Fi and shots feel random, that's why.

### Scripts or the app trip antivirus

They don't, in our testing, on a clean Windows 11 install. If your AV does flag
them, you're running something else that's rewriting files, or your AV is
heuristic-heavy. Check what else is hooking input.

### Zen Studio won't detect the Zen

Different USB port, preferably rear-panel, and reinstall Zen Studio. Nothing to
do with this pack — the scripts are plain text files the Zen Studio compiler
reads.

---

## Before you open an issue

Include:

1. **Which script** — the exact filename
2. **Platform** — PC / PS / Xbox
3. **Controller** — model and connection type
4. **What happens** — "always late by a quarter second" beats "broken"
5. **Patch date** — timings drift after every game update

Issues without these get closed with a link to this file.

---

## Discord

`discord.gg/slem` — fastest place for setup help, and where patch-day timing
corrections get posted before they land here.
