# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles for Debian/Ubuntu. All configs are managed as **symlinks** — `install.sh` links each file from `~/git/dotfiles/` into `$HOME`. Editing `~/.config/kitty/kitty.conf` and editing the repo file are the same thing.

## Install and update

**Fresh machine (one-liner):**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/espenotterstad/dotfiles/main/bootstrap.sh)
```

**After pulling changes on an existing machine:**
```bash
./install.sh   # re-links any newly added files
```

## Architecture

`bootstrap.sh` → `install.sh` → symlinks into `$HOME`

- `bootstrap.sh` — one-time setup: apt installs, Nerd Font download, atuin history import, then calls `install.sh`
- `install.sh` — idempotent symlinking; backs up pre-existing real files to `~/.dotfiles-backup/<timestamp>/`

**Adding a new config file:**
1. Place it in the repo under the same relative path it would live under `$HOME`
2. Add an entry to the `LINKS` associative array in `install.sh`
3. Run `./install.sh`

## Critical ordering in `.bashrc`

Starship **must** be initialised before atuin. Atuin sets `precmd_functions`; if starship sees that already set, it switches to bash-preexec mode and the prompt stops rendering. The comment in `.bashrc` explains this — don't reorder those `eval` blocks.

## Switching themes

The active kitty theme is set by the `include` line at the bottom of `.config/kitty/kitty.conf` — swap between `gruvbox-dark.conf` and `catppuccin-mocha.conf`. When switching, also update the `palette` key in `.config/starship.toml` to match.
