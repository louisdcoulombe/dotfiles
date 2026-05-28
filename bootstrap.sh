#!/bin/bash
set -e
DOTFILES="$HOME/dotfiles"

# ---- Packages ----------------------------------------------------------------
install_packages() {
  if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  local pkgs=(jq yq bash gum fzf tmux neovim gh mise)
  local missing=()
  for p in "${pkgs[@]}"; do
    brew list --formula "$p" >/dev/null 2>&1 || missing+=("$p")
  done
  if [ "${#missing[@]}" -gt 0 ]; then brew install "${missing[@]}"; fi
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
ln -sfn "$DOTFILES/nvim"         "$HOME/.config/nvim"

# Zsh config
ln -sfn "$DOTFILES/zsh"          "$HOME/.config/zsh"

# mise
mkdir -p "$HOME/.config/mise"
ln -sf "$DOTFILES/mise/config.toml" "$HOME/.config/mise/config.toml"
mise trust "$HOME/.config/mise/config.toml"
mise install

if [ "$(uname)" = "Darwin" ]; then
  ln -sf "$DOTFILES/hammerspoon"  "$HOME/.hammerspoon"
  ln -sf "$DOTFILES/karabiner"    "$HOME/.config/karabiner"
  mkdir -p "$HOME/.config/ghostty"
  ln -sf "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"
fi
