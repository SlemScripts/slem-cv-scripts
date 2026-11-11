# Support

Read the guide for your platform in `SLEM-CV/` before anything else. Nine out of
ten questions are answered there.

---

## Common issues

### The app doesn't see my controller

You didn't run the setup, or you ran it without administrator rights.

Right-click `SLEM-CV\Start Setup.bat` → **Run as administrator** → **Yes**.

The bridge registers a virtual controller driver and hides your physical pad
from the game, giving it a virtual one instead. Windows only allows a driver
registration from an elevated process — running the bat normally looks like it
worked, then the app launches, shows the overlay, and reads nothing.

Run it once per PC. Re-run it after a Windows feature update — those reset the
driver registration.

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

### The setup won't finish, or the app closes itself

Almost always the bridge didn't complete its first run.

Run `SLEM-CV\Start Setup.bat` again, this time right-clicking and choosing
**Run as administrator**. The script reopens itself elevated if it has to —
click **Yes** on the prompt. Setup needs to finish before the app is opened;
if the app was already running, close it first, run the setup, then open it
again.

If setup finishes but the app still closes on launch, make sure you extracted
the ZIP to a real folder (Desktop or Documents). Running out of a compressed
archive, a temp download folder, or a network share leaves the bridge
components unwritable.

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
