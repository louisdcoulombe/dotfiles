#!/bin/bash
set -e
DOTFILES="$HOME/dotfiles"

# Shell
ln -sf "$DOTFILES/.zshrc"       "$HOME/.zshrc"

# tmux
ln -sf "$DOTFILES/.tmux.conf"   "$HOME/.tmux.conf"

# Neovim
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES/nvim"         "$HOME/.config/nvim"

# Zsh config
ln -sf "$DOTFILES/zsh"          "$HOME/.config/zsh"

if [ "$(uname)" = "Darwin" ]; then
  ln -sf "$DOTFILES/hammerspoon"  "$HOME/.hammerspoon"
  ln -sf "$DOTFILES/karabiner"    "$HOME/.config/karabiner"
fi
