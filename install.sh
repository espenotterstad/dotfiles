#!/usr/bin/env bash
# install.sh — symlink dotfiles into place
# Run this after cloning on a new machine.
# Existing files are backed up to ~/.dotfiles-backup/

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# Files to symlink: "source-in-repo -> dest-in-home"
declare -A LINKS=(
    [".bashrc"]=".bashrc"
    [".gitconfig"]=".gitconfig"
    [".config/starship.toml"]=".config/starship.toml"
    [".config/kitty/kitty.conf"]=".config/kitty/kitty.conf"
    [".config/kitty/gruvbox-dark.conf"]=".config/kitty/gruvbox-dark.conf"
    [".config/kitty/catppuccin-mocha.conf"]=".config/kitty/catppuccin-mocha.conf"
    [".config/kitty/open-actions.conf"]=".config/kitty/open-actions.conf"
    [".config/kitty/ssh.conf"]=".config/kitty/ssh.conf"
    [".config/atuin/config.toml"]=".config/atuin/config.toml"
    [".config/Code/User/settings.json"]=".config/Code/User/settings.json"
)

echo "→ Installing dotfiles from $DOTFILES_DIR"

for src in "${!LINKS[@]}"; do
    dest="$HOME/${LINKS[$src]}"
    full_src="$DOTFILES_DIR/$src"

    # Ensure parent directory exists
    mkdir -p "$(dirname "$dest")"

    # Back up if a real file (not already our symlink) exists
    if [[ -e "$dest" && ! -L "$dest" ]]; then
        mkdir -p "$BACKUP_DIR"
        cp -r "$dest" "$BACKUP_DIR/$(basename "$dest")"
        echo "  backed up $dest → $BACKUP_DIR/$(basename "$dest")"
    fi

    # Create symlink
    ln -sf "$full_src" "$dest"
    echo "  linked $dest → $full_src"
done

echo ""
echo "✓ Done. Open a new shell or run: source ~/.bashrc"
echo ""

# Remind about one-time steps that can't be symlinked
echo "One-time steps still needed on a new machine:"
echo "  1. Run ./bootstrap.sh to install all packages + fonts"
echo "  2. Set git user.name: git config --global user.name 'Espen Otterstad'"
echo "  3. Restart kitty after bootstrap to load shell integration"
