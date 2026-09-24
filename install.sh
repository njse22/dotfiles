#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Setting up dotfiles configuration symlinks from $DOTFILES_DIR..."

# Helper function to create symlink
link_item() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ]; then
        echo "Warning: Source $src does not exist. Skipping."
        return
    fi

    # Create parent directory of destination if it doesn't exist
    mkdir -p "$(dirname "$dest")"

    if [ -L "$dest" ]; then
        echo "Removing existing symlink: $dest"
        rm "$dest"
    elif [ -e "$dest" ]; then
        echo "Backing up existing file/dir $dest to ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi

    echo "Linking $src -> $dest"
    ln -s "$src" "$dest"
}

# 1. Zsh
link_item "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
link_item "$DOTFILES_DIR/zsh/aliases.zsh" "$HOME/.aliases.zsh"

# 2. Tmux
link_item "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# 3. Neovim
link_item "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# 4. Fastfetch
link_item "$DOTFILES_DIR/fastfetch" "$HOME/.config/fastfetch"

# 5. Navi
link_item "$DOTFILES_DIR/navi" "$HOME/.local/share/navi"

# 6. Rofi
link_item "$DOTFILES_DIR/rofi" "$HOME/.config/rofi"

# 7. Opencode
if [ -d "$DOTFILES_DIR/opencode" ]; then
    link_item "$DOTFILES_DIR/opencode" "$HOME/.config/opencode"
fi

echo "==> Dotfiles setup completed successfully!"
