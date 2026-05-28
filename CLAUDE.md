# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Personal dotfiles for macOS. Manages shell config, editor, terminal multiplexer, and window manager settings.

## Architecture

This repo uses a **manual symlink approach** via `bootstrap.sh`. Files are symlinked from `~/.dotfiles/` into the home directory rather than copied. There is no automated install framework (no stow, no chezmoi).

### Key components

| Path | Target | Notes |
|------|--------|-------|
| `.zshrc` | `~/.zshrc` | z4h (zsh-for-humans) shell; auto-starts tmux; sources `~/.config/zsh/*.zsh` |
| `zsh/` | `~/.config/zsh/` | Per-context zsh files sourced by `.zshrc` glob (`*.zsh`) |
| `.tmux.conf` | `~/.tmux.conf` | Prefix is `C-a`; vi copy-mode; hjkl pane navigation |
| `nvim/` | `~/.config/nvim/` | kickstart.nvim base with custom plugins in `lua/custom/plugins/` |
| `hammerspoon/` | `~/.hammerspoon/` | macOS automation (keybindings, app switching, USB events) |
| `karabiner/` | `~/.config/karabiner/` | Key remapping |

### Zsh loading order

1. `~/.zshrc` (z4h init + shared aliases/settings)
2. `~/.oh-my-zsh/custom/*.zsh` (alphabetical) — workspace-specific files live here (`nesto.zsh`, `solid.zsh`, etc.)
3. `~/.config/zsh/*.zsh` (glob, alphabetical) — additional local overrides

### Neovim structure

- `nvim/init.lua` — entry point; sets options, installs lazy.nvim, loads plugin specs
- `nvim/lua/custom/plugins/` — all custom plugin configs (LSP, telescope, harpoon, avante, copilot, DAP, etc.)
- `nvim/lua/kickstart/plugins/` — kickstart base plugins (debug, indent_line)
- Leader key: `<Space>`

### Hammerspoon structure

`hammerspoon/init.lua` bootstraps modules: `apps`, `keybindings`, `usb`. Each module exposes an `init()` function. Reload config via `hs.reload()` or the keybinding defined in `keybindings.lua`.

## Applying changes

- **Zsh changes**: `reload` (alias for `exec zsh`) or open a new shell.
- **tmux config**: `<prefix> r` (bound to `source-file ~/.tmux.conf`).
- **Neovim plugins**: `:Lazy` inside nvim; `:Lazy update` to update.
- **Hammerspoon**: `hs.reload()` or the reload keybinding; watch for "Config loaded" alert.
- **New dotfiles symlink**: add an `ln -s` entry to `bootstrap.sh` and run it manually.

## Security note

`oh_my_zsh/custom/nesto.zsh` contains a hardcoded Jira API token. Consider replacing it with a reference to a secrets manager (1Password CLI, `op read`) or a file excluded from git.
