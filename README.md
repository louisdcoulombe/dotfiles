# dotfiles

Personal macOS dotfiles managed via manual symlinks.

## Install

```sh
./bootstrap.sh
```

Installs Homebrew packages, then symlinks configs into place.

## What's included

| Component | Source | Target |
|-----------|--------|--------|
| Zsh | `.zshrc`, `zsh/` | `~/.zshrc`, `~/.config/zsh/` |
| tmux | `.tmux.conf` | `~/.tmux.conf` |
| Neovim | `nvim/` | `~/.config/nvim/` |
| Hammerspoon | `hammerspoon/` | `~/.hammerspoon/` |
| Karabiner | `karabiner/` | `~/.config/karabiner/` |
| Ghostty | `ghostty/config` | `~/.config/ghostty/config` |
| mise | `mise/config.toml` | `~/.config/mise/config.toml` |
