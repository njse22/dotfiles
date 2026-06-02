# dotfiles — AGENTS.md

## Repo structure
```
nvim/        → ~/.config/nvim
  lua/config/ plugins/ general.lua     # lazy.nvim plugin specs
  coc-settings.json                     # coc.nvim LSP config (Python, Ansible, LaTeX)
zsh/
  zshrc       → ~/.zshrc                # oh-my-zsh + powerlevel10k
  aliases.zsh → ~/.aliases.zsh          # sourced from .zshrc; fzf tools, env vars, py-venv
tmux/
  tmux.conf   → ~/.tmux.conf            # tpm plugins, prefix=C-q, kiss-tmux theme
fastfetch/    → ~/.config/fastfetch/
navi/         → ~/.local/share/navi/    # community cheat sheets
rofi/         → ~/.config/rofi/
setup.sh                                # **OUTDATED** (declared in script header) — do not use
README.md                               # documents symlink targets
```

## Key conventions
- **EDITOR** is `nvim` (set via `$EDITOR` in `aliases.zsh`)
- nvim leader is `,` (comma)
- tmux prefix is `C-q` (not `C-b`)
- zsh aliases (`~/.aliases.zsh`) and secrets (`~/.keys.zsh`) are sourced from `.zshrc`
- `~/.fzf.zsh`, `~/_gowall` also sourced from `.zshrc`
- Plugins managed via **lazy.nvim** (bootstrap in `init.lua`) and **tpm** (tmux)

## Notable tools / functions
- `py-venv` (bash function in aliases.zsh): manage Python venvs under `~/.venv/`
- `fzf-tool` (`C-F`): menu-driven fzf helper (file explorer, man pages, venvs, app launcher)
- `__fzf_open_file_or_dir` (`C-P`): file/directory picker with preview
- Several custom tmux popup/menu bindings (prefix `m` for menu, `O` for popup terminal)

## LSP & language servers (coc.nvim)
- Python: pyright
- Ansible: ansible-language-server
- LaTeX: ltex-ls (Spanish mother tongue)
- Java: JDK 17, Gradle wrapper

## Setup
`setup.sh` is **not reliable** (self-declared outdated). Configs are deployed by symlinking files from repo to `$HOME` per the table in README.md.

No build/test/lint commands — this is a static config repo.
