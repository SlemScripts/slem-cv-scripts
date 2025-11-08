# Contributing

Fork, cook, PR. That's the whole process.

---

## What we want

**New scripts.** If you've worked out timings that hold up on the current patch,
open a PR. Include the script and a clip or a note saying which mode and build
you tested on.

**Timing corrections.** Game patches move the green window. If a script in here
feels late or early after an update, the `define` block at the top is usually
one number off. PR the corrected value with your platform in the description.

**Guide fixes.** Button mappings change. If a step in a PDF doesn't match what
you see on screen, tell us.

---

## What we don't want

- **Re-uploads.** Nine of the scripts we removed were the same file with renamed
  variables. If your script is `SomeoneElses_V2` with `TIMING` changed to
  `TIMING_2`, it's not a contribution.
- **Random-delay "AI" scripts.** A `wait(rand(20,60))` loop is not adaptive.
- **Obfuscated scripts.** Nobody can review them and nobody should run them.

---

## Script format

Keep the header block:

```c
/*
 * <Name> — <game> <patch>
 * <one line on what it does>
 *
 * Tested: <platform>, <controller>
 */
```

Keep your tunables at the top as `define`s with a comment on the range that
works:

```c
define TIMING_BASE = 38;    // 34-42, lower = earlier release
```

If a value needs tuning per player, say so in the comment. Half the issues we
get are someone running a tuned script on a different monitor.

---

## PR checklist

- [ ] Compiles in Zen Studio (F7) with no warnings
- [ ] Placed in the right `scripts/<game>/` folder
- [ ] Header block filled in
- [ ] Tested on the platform named in the header
- [ ] Not a re-upload of something already in the repo

---

## Issues

Use the issue tab for:

- **Script not working** — say which script, which platform, what it does
  instead. "Doesn't work" gets closed.
- **Game patched, timings off** — say the patch date.
- **Guide is wrong** — say which PDF and which step.

Before opening an issue about the app not seeing your controller: run the setup
in `SLEM-CV/` first. That's the cause roughly every time.
