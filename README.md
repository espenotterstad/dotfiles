# dotfiles

Personal dev environment for Debian/Ubuntu — kitty, starship, git, atuin, and friends.

## What's included

| File | Purpose |
|---|---|
| `.bashrc` | Shell aliases, tool init order (starship first!) |
| `.gitconfig` | delta pager, VS Code merge/diff tool, sane defaults |
| `.config/starship.toml` | Gruvbox Dark powerline prompt |
| `.config/kitty/kitty.conf` | Kitty terminal — font, theme, splits, keybindings |
| `.config/kitty/gruvbox-dark.conf` | Gruvbox Dark colour theme |
| `.config/kitty/catppuccin-mocha.conf` | Catppuccin Mocha (alternative theme) |
| `.config/kitty/open-actions.conf` | Ctrl+Shift+click paths → open in VS Code |
| `.config/kitty/ssh.conf` | `kitten ssh` defaults |
| `.config/atuin/config.toml` | Atuin history (local-only, fuzzy, compact UI) |

## Fresh machine setup

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/espenotterstad/dotfiles/main/bootstrap.sh)
```

That's it. The script will:
1. Clone this repo to `~/git/dotfiles`
2. `apt install` all packages (kitty, firacode, delta, lazygit, fzf, zoxide, eza, bat, starship, atuin)
3. Download Symbols Nerd Font (for prompt icons)
4. Import existing shell history into atuin
5. Symlink all configs into place (backs up any existing files)

## Updating an existing machine

After pulling changes:

```bash
cd ~/git/dotfiles
git pull
./install.sh   # re-links any new files
```

The configs themselves are symlinked, so edits you make directly to `~/.config/kitty/kitty.conf`
etc. are already live in the repo — just `git add` and commit.

## Key bindings (kitty)

| Action | Keys |
|---|---|
| New horizontal split | `Ctrl+Shift+Enter` |
| New vertical split | `Ctrl+Shift+\` |
| Move focus | `Alt+←/→/↑/↓` |
| Zoom split | `Ctrl+Shift+Z` |
| Next layout | `Ctrl+Shift+L` |
| New tab (same cwd) | `Ctrl+Shift+T` |
| Reload config | `Ctrl+Shift+F5` |

## Shell aliases

| Alias | Expands to |
|---|---|
| `ll` | `eza -l --git` |
| `la` | `eza -la --git` |
| `lt` | `eza --tree` |
| `lg` | `lazygit` |
| `cat` | `batcat --paging=never` |
| `d` | `kitten diff` |
| `s` | `kitten ssh` |
| `z <dir>` | zoxide smart jump |
| `Ctrl+R` | atuin history picker |
| `Ctrl+T` | fzf file picker |
| `Alt+C` | fzf directory picker |

## Switching themes

The kitty theme is set via `include gruvbox-dark.conf` at the bottom of `kitty.conf`.
Swap to `include catppuccin-mocha.conf` and update `starship.toml` palette accordingly.
