#!/bin/bash
set -e
DOTFILES="$HOME/dotfiles"

# Shell
ln -sf "$DOTFILES/.zshrc"       "$HOME/.zshrc"

# tmux
ln -sf "$DOTFILES/.tmux.conf"   "$HOME/.tmux.conf"

# TPM (Tmux Plugin Manager)
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# Neovim
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES/nvim"         "$HOME/.config/nvim"

# Zsh config
ln -sf "$DOTFILES/zsh"          "$HOME/.config/zsh"

if [ "$(uname)" = "Darwin" ]; then
  ln -sf "$DOTFILES/hammerspoon"  "$HOME/.hammerspoon"
  ln -sf "$DOTFILES/karabiner"    "$HOME/.config/karabiner"
fi
