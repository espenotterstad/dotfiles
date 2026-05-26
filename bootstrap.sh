#!/usr/bin/env bash
# bootstrap.sh — fresh machine setup (Debian/Ubuntu)
# Installs all packages, fonts, then symlinks dotfiles.
#
# One-liner for a new machine:
#   bash <(curl -fsSL https://raw.githubusercontent.com/espenotterstad/dotfiles/main/bootstrap.sh)
#
# Or if you've already cloned:
#   cd ~/git/dotfiles && ./bootstrap.sh

set -euo pipefail

DOTFILES_REPO="https://github.com/espenotterstad/dotfiles.git"
DOTFILES_DIR="$HOME/git/dotfiles"

# Clone if running the script from outside the repo (e.g. via curl | bash)
if [[ ! -d "$DOTFILES_DIR/.git" ]]; then
    echo "→ Cloning dotfiles…"
    mkdir -p "$(dirname "$DOTFILES_DIR")"
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

echo "════════════════════════════════════════"
echo " Dotfiles bootstrap — Debian/Ubuntu"
echo "════════════════════════════════════════"
echo ""

# ── Packages ─────────────────────────────────────────────────────────
echo "→ Installing packages…"
sudo apt update -qq
sudo apt install -y \
    kitty \
    fonts-firacode \
    git \
    git-delta \
    lazygit \
    fzf \
    zoxide \
    eza \
    bat \
    starship \
    atuin \
    code        # VS Code — remove if not needed

echo ""

# ── Nerd Fonts (symbol-only, for prompt icons) ────────────────────────
echo "→ Installing Symbols Nerd Font…"
NERD_FONT_DIR="$HOME/.local/share/fonts/NerdFontsSymbolsOnly"
mkdir -p "$NERD_FONT_DIR"

NERD_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip"
TMP_ZIP="$(mktemp --suffix=.zip)"
curl -fsSL "$NERD_URL" -o "$TMP_ZIP"
unzip -o -q "$TMP_ZIP" -d "$NERD_FONT_DIR"
rm "$TMP_ZIP"
fc-cache -f "$NERD_FONT_DIR"
echo "  ✓ Symbols Nerd Font installed"
echo ""

# ── Atuin history import ──────────────────────────────────────────────
echo "→ Importing existing shell history into atuin…"
atuin import auto 2>/dev/null || true
echo ""

# ── Symlink dotfiles ──────────────────────────────────────────────────
echo "→ Symlinking dotfiles…"
bash "$DOTFILES_DIR/install.sh"

echo ""
echo "════════════════════════════════════════"
echo " Bootstrap complete!"
echo "════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "  1. Restart kitty (or open a new terminal)"
echo "  2. Set your git identity:"
echo "     git config --global user.name 'Espen Otterstad'"
echo "     git config --global user.email 'espen@otterstad.me'"
echo "  3. Optionally register atuin sync:"
echo "     atuin register  (or: atuin login)"
