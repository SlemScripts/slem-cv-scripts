# Changelog

All notable changes to this pack. Scripts keep their own version in the
`define` block; this file tracks the pack as a whole.

Format: `YYYY.MM.DD` — newest first.

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
