# dotfiles - Agent Instructions

##  Constraints & Setup
- This is a configuration repository, not a deployable application.
- Do not use `setup.sh`. Configurations are managed by symlinking files from this repo to `$HOME` (see `README.md` for the map).

##  Conventions & Shortcuts
- **Editor:** `nvim`. Leader key is `,`.
- **Tmux Prefix:** `C-q` (not `C-b`).
- **Shell:** Zsh. Aliases and environment secrets are sourced from `.zshrc` and `~/.aliases.zsh`.
- **LSP:** `coc.nvim` is used. Key language servers: `pyright`, `ansible-language-server`, `ltex-ls`.

##  High-Signal Tools
- `py-venv` (in `aliases.zsh`): Manages Python virtual environments under `~/.venv/`.
- `fzf-tool` (`C-F`): Menu-driven fzf helper (app launcher, file explorer, venvs).
- `__fzf_open_file_or_dir` (`C-P`): File/directory picker with preview.

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
