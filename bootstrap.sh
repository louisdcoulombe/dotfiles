#!/bin/bash
set -e
DOTFILES="$HOME/dotfiles"

# ---- Packages ----------------------------------------------------------------
install_packages() {
  if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  local pkgs=(jq yq bash gum fzf tmux neovim gh)
  local missing=()
  for p in "${pkgs[@]}"; do
    brew list --formula "$p" >/dev/null 2>&1 || missing+=("$p")
  done
  [ "${#missing[@]}" -gt 0 ] && brew install "${missing[@]}"
}

install_packages

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
