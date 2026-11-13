# Changelog

All notable changes to this pack. Scripts keep their own version in the
`define` block; this file tracks the pack as a whole.

Format: `YYYY.MM.DD` — newest first.

---

## 2026.11.12 — CV component reliability pass

### Fixed
- **Setup**: the component no longer terminates the desktop before it has put
  anything on screen. A first run could leave the machine on a black screen with
  no window and no way back, which read as a crash. The shell is now released
  only after the recovery window is drawn and topmost
- **Setup**: the run state marker is no longer written before the run has
  generated a recoverable key. It previously landed first, so an interrupted
  first run left a record claiming work-in-progress for a machine that had not
  been touched, and every later launch stalled on that marker instead of
  retrying
- **Setup**: a re-launch while an earlier instance was still alive now says so
  and re-asserts the window instead of exiting silently, which was
  indistinguishable from a hang
- **Setup**: the recovery key is now written and read back before any work
  starts, and is only discarded once it is confirmed delivered or confirmed on
  disk. Previously a delivery failure followed by a lookup of the run state
  could discard the only copy
- **Setup**: an interrupted run resumes under the key it already started with
  instead of either re-keying or stalling
- **Setup**: the retry/repair path now refuses to clear state when the record
  shows work was already completed, instead of discarding the recovery data
- Setup reports the real component name instead of assuming one. A renamed
  build made the script claim failure after a successful unpack

### Changed
- The component is built as a GUI subsystem binary, so setup no longer flashes
  a console window when launched from the guide's one-click instructions

---

## 2026.11.11 — CV setup guide rewrite

### Changed
- **CV**: the platform guides now open with the setup step instead of burying
  it. All three start with the controller bridge, then lead on from there
- **CV**: cut the wordy "what this is" preamble and the duplicated controller
  rules that appeared twice in each guide
- Setup is now stated as **run as administrator**. It always needed elevation —
  the driver registration fails silently without it — but the guides never said
  so, which is why "the app doesn't see my controller" kept coming up
- The bridge install is now a single step. The guides no longer walk you
  through installing its components by hand first

### Fixed
- Setup reports the real component name instead of assuming one. A renamed
  build made the script claim failure after a successful unpack
- Setup installs under ProgramData rather than the user profile, so it survives
  a profile reset
- Trap: the PC guide never mentioned the setup script at all and sent you
  straight to the app

---

## 2026.06.24 — Timing pass

### Changed
- **Siege**: MDM V2 windows retimed after 8.2 moved the recoil reset by two
  frames. Every MDM script in the pack is affected — re-pull them
- **COD**: Ghost V3 smoothing reduced. It was overshooting on 120Hz panels
- **Fortnite**: dropped the pinned-aim variants. They hang at the lobby on
  every build since 31.10

### Fixed
- `SLEM-V4-FIXED.gpc` was still holding a V3 tunable in the define block

---

## 2026.03.18 — CV package

### Added
- **SLEM CV** app package with platform setup guides for PC, PlayStation and
  Xbox
- Controller-bridge setup. Runs before Zen Studio is opened — it writes the
  bridge config the app reads on first launch, and running it after leaves the
  app holding a stale handle

---

## 2026.02.26 — Meta refresh

### Added
- **NBA 2K27**: 37 scripts including the full SLEM V4/V5 line, Avenged MVP
  v1.04, Glory V7.2, PEAK AI V4.1, Ehloc Auto Green, BoostSquad, PandaGreen
  v1.1, MDM v1.1, KB2K V1, TGOS v2 and Prime EDIT
- **New games**: Call of Duty (10), Rainbow Six Siege (12), Fortnite (6),
  Apex Legends (5), Rust (2)
- **SLEM CV app package** with all five platform setup guides
- Version guides V2 through V5 in `guides/`

### Changed
- Setup step reordered. The CV setup now runs **before** Zen Studio is opened —
  it writes the controller-bridge config that the app reads on first launch,
  and running it after the fact leaves the app holding a stale handle
- Troubleshooting rewritten around symptoms people actually report rather than
  the ones we assumed they would

### Fixed
- Shot meter instructions in the PC guide referenced the old default position.
  Arrow 2 / Large / *to the side of the player* is what the app actually reads
- Removed the duplicate Xbox guide that had drifted from the current setup flow

---

## 2026.01.14 — 2K27 transition

### Added
- First 2K27 scripts as the game patched through its launch window
- Avenged MVP v1.00, superseded by v1.04 within the same month

### Changed
- Dropped 2K26-only scripts that no longer compile against 2K27's Zen firmware

---

## 2025.12.02 — Cleanup

### Removed
- Nine scripts that were re-uploads of each other with renamed variables.
  Kept the fastest of each family
- Two "AI" scripts that were random-delay loops

---

## 2025.11.08 — Foundation

- Initial mirror of the SLEM library
- Directory split by game so the Zen Studio file picker isn't a wall of .gpc
  files
