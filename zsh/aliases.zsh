#          ___
#   ____ _/ (_)___ ______
#  / __ `/ / / __ `/ ___/
# / /_/ / / / /_/ (__  )
# \__,_/_/_/\__,_/____/
#

#######################################################################
#                               COLORS                                #
#######################################################################

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

COLOR_BLACK='\033[0;30m'
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_ORANGE='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_PURPLE='\033[0;35m'
COLOR_CYAN='\033[0;36m'
COLOR_LIGHT_GRAY='\033[0;37m'
COLOR_DARK_GRAY='\033[1;30m'
COLOR_LIGHT_RED='\033[1;31m'
COLOR_LIGHT_GREEN='\033[1;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_LIGHT_BLUE='\033[1;34m'
COLOR_LIGHT_PURPLE='\033[1;35m'
COLOR_LIGHT_CYAN='\033[1;36m'
COLOR_WHITE='\033[1;37m'
NC='\033[0m' # No Color / Reset

#######################################################################
#                        ENVIRONMENT VARIABLES                        #
#######################################################################

export EDITOR="nvim"

# CTRL-Y to copy the command into clipboard using wl-copy
export FZF_CTRL_R_OPTS="
--style full
--bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy )+abort'
--color header:italic
--header 'Press CTRL-Y to copy command into clipboard'"

export NVIM_DIR="$HOME/.local/share/nvim/"
export NVIM_RC="$HOME/.config/nvim/init.vim"

export GOPATH="/opt/go"

export JAVA_HOME="/usr/lib/jvm/java-1.17.0-openjdk-amd64/"

export LTEX_LS_PATH="$HOME/Software/ltex-ls-16.0.0-linux-x64/ltex-ls-16.0.0"

## UPDATE PATH VARIABLE
export PATH=$PATH:"$GOPATH/bin"
export PATH=$PATH:"/usr/local/go/bin"
export PATH=$PATH:"$HOME/.tmuxifier/bin"
export PATH=$PATH:"$LTEX_LS_PATH/bin"
export PATH=$PATH:"$HOME/.local/bin"

#######################################################################
#                            CUSTOM ALIAS                             #
#######################################################################

alias gr="grep --exclude-dir=build --exclude-dir=swig --exclude-dir=.git --exclude=tags -rniI "
alias v='nvim'
alias vr='nvim -R'
alias vf='nvim $(fzf --height 50% --reverse --border --preview "batcat --style=numbers --color=always --line-range :500 {}")'
# ps -ef | fzf --reverse --header-lines 1 --header-border bottom --input-border --color nth:regular,fg:dim
alias psf='ps -ef | fzf --height 50% --reverse --border'
alias lt='tree'
alias cl='clear'
alias vimrc='v ~/.config/nvim/init.lua'
alias tmuxrc='nvim ~/.tmux.conf'
alias zshrc="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias killZombie="kill $(ps -A -ostat,ppid | awk '/[zZ]/{print $2}')"
alias killps="ps -ef | fzf | awk '{print $2}' | xargs kill"
alias weather='curl https://wttr.in'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias :q='exit'
alias :Q='exit'
alias qr='qrencode -t ansiutf8'
alias gogh='bash -c "$(wget -qO- https://git.io/vQgMr)"'
alias gitinspector='/home/i2t/Git/gitinspector/gitinspector.py'
alias bat='batcat'
# This alias needs:
# 1. SEAMCAT jar file exist
# 2. update SEAMCAT jar version
alias SEAMCAT='/usr/local/java/jre1.8.0_411/bin/java -jar ~/Software/SEAMCAT-5.5.0-OFFICIAL.jar'

#######################################################################
#                          CUSTOM FUNCTIONS                           #
#######################################################################

# clear ; for t in "Wake up" "The Matrix has you" "Follow the white rabbit" "Knock, knock";do clear;pv -qL10 <<<$'\e[2J'$'\e[32m'$t$'\e[37m';sleep 5;done; cmatrix
function neo() {
  clear
  for t in "Wake up..." "The Matrix has you..." "Follow the white rabbit." "Knock, knock."; do
    clear
    pv -qL10 <<<$'\e[2J'$'\e[32m'$t$'\e[37m'
    sleep 5
  done
  cmatrix
}

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#61b0a8,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#25bcda,label:#fb9c64,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded"
  --marker="" --pointer="" --separator="─" --scrollbar="│"'


function fzf-tool() {

    local show_preview="
    ${COLOR_BLUE}
             ___________   ______
            / ____/__  /  / ____/
           / /_     / /  / /_
          / __/    / /__/ __/
         /_/      /____/_/
     
     [  FZF Tool Helper @njse22  ]
    ${NC}
    "

    typeset -A menu_dict
    menu_dict=(
      "File Explorer"        "Open file on nvim or cd folder"
      "Man Pages"            "Manuals Explorer"
      "Python VENV"          "Tool for management python venv"
      "Application Launcher" "Clasical App Launcher"
    )

    selected=$( printf "%s\t%s\n" "${(@kv)menu_dict}" |  
	fzf \
	--tmux 70% \
	--delimiter='\t' \
	--with-nth=1 \
        --preview-window 60% \
	--preview="echo '${show_preview}' '${COLOR_CYAN}' {2}" \
	--border="rounded" \
	--border-label=" FZF Tools " \
	--border-label-pos="0" \
	--prompt="FZF Tool  " \
	--pointer="" \
	--separator="─" \
	--scrollbar="│" \
	--info="right" \
    )

    key=$(echo "$selected" | cut -f1)

    case "$key" in

	*"File Explorer")
	    __fzf_open_file_or_dir;
	  ;;
	*"Man Pages")
	    __fzf_manpages
	  ;;
	*"Python VENV")
	    __fzf_py_env
	  ;;
	*"Application Launcher")
	    __fzf_menu
	  ;;
    esac
}

zle -N fzf-tool 
bindkey '^F' fzf-tool

# Features to add:
#   1. Image support -> chafa or use kitty terminal
#   2. Write an application launcher:
#     - https://github.com/junegunn/fzf/wiki/Examples#fzf-as-dmenu-replacement
#     - https://github.com/junegunn/fzf/wiki/Examples#buku
#     - https://github.com/levinion/fzfmenu
# zsh -c "exec systemd-run --user  $(ls /usr/share/applications | awk -F'.desktop' '{print $1}' | fzf)" 2> /dev/null
#   3. Write a key cheet sheep helper like navi (?)
#

# This is the same functionality as fzf's ctrl-t, except that the file or
# directory selected is now automatically cd'ed or opened, respectively.
function __fzf_open_file_or_dir() {
  zle -I

  local show_preview='
    if [ -f {} ]; then 
	batcat -n --color=always {}
    elif [ -d {} ]; then
	tree -C {}
    fi'

  local menu_string="
    ${COLOR_BLUE}
		___________   ______
	       / ____/__  /  / ____/
	      / /_     / /  / /_
	     / __/    / /__/ __/
	    /_/      /____/_/

    [            Menu Options            ]
    ${NC}
    ${COLOR_CYAN}
    1. CTRL - /  : Toggle Layouth
    2. ALT - D   : Create Directory
    3. ALT - F   : Create File
    4. CTRL - A  : Search All
    5. CTRL - D  : Search Only Directories
    6. CTRL - F  : Search Only Files 
    7. CTRL - C  : Search Hidden Files
    8. ESC	 : Exit 
    ${NC}
    "

  local cmd="command find -L . \
    \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | sed 1d | cut -b3-"

  local out=$(
    eval $cmd |
      fzf \
        --style full \
        --pointer='' \
	--prompt="FZF file/dir  " \
        --walker-skip .git,node_modules,target \
        --preview-window 45% \
        --preview "$show_preview" \
        --bind "?:preview:echo '$menu_string'" \
        --bind 'ctrl-/:change-preview-window(down|hidden|)' \
        --bind "alt-d:execute(mkdir -p {q})+reload($cmd)" \
        --bind "alt-f:execute-silent(touch {q})+reload($cmd)" \
        --bind "ctrl-a:change-prompt(Search )+reload($cmd)" \
        --bind 'ctrl-d:change-prompt(Directories )+reload(find * -type d -maxdepth 3)' \
        --bind 'ctrl-f:change-prompt(Files )+reload(find * -type f)' \
        --bind "ctrl-c:change-prompt(Hidden )+reload(find . -maxdepth 2 -name '.*')" \
        --header 'Press ? to toggle menu'
  )

  if [ -f "$out" ]; then
    "$EDITOR" "$out" </dev/tty
  elif [ -d "$out" ]; then
    BUFFER="cd $out"
    CURSOR=$#BUFFER
    zle reset-prompt
  fi
}

zle -N __fzf_open_file_or_dir
bindkey '^P' __fzf_open_file_or_dir

function __fzf_menu() {
    local xdg_dirs=(${(s.:.)XDG_DATA_DIRS}) ## ref. man 7 wofi 
    
    local desktop_files=($^xdg_dirs/applications/*.desktop(N)) ## only works with zsh 

    local seleccion=$(awk -F= '
        /^Name=/ { if(!n) n=$2 } 
        /^Exec=/ { if(!e) { e=$0; sub(/^Exec=/, "", e); sub(/ %[a-zA-Z].*/, "", e) } } 
        /^Terminal=true/ { term=1 } 
        ENDFILE  { 
            if(n && e && !term) print n "\t" e; 
            n=""; e=""; term=0 
        }
    ' $desktop_files | sort -u | fzf \
	--delimiter='\t' \
	--with-nth=1 \
	--tmux 40% \
	--border="rounded" \
	--border-label=" Apps " \
	--border-label-pos="0" \
	--prompt="ApplicationLauncher  " \
	--pointer="" \
	--separator="─" \
	--scrollbar="│" \
	--info="right" \
    )

    if [[ -n "$seleccion" ]]; then
        local cmd=$(echo "$seleccion" | cut -f2)
        # print -P "%F${COLOR_GREEN}Opening:%f $cmd"
        nohup zsh -c "$cmd" >/dev/null 2>&1 &!
    fi
}

function __fzf_manpages() {
  man -k . |
    fzf -q "$1" --prompt='Manpages ' \
      --preview-window down \
      --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' |
    tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}

function __fzf_py_env() {
  local venv_dir=$HOME/.venv
  local opt=$(functions py-venv)

  local out=$(ls $venv_dir |
    FUNC_BODY="$opt" fzf \
      --tmux 60% \
      --prompt="Python venv  " \
      --pointer '' \
      --border-label ' py-venv (Helper to python envioroments) ' --input-label ' Input ' \
      --header 'Press ALT-C (create) / ALT-R (remove) / ENTER (activate)' \
      --bind "alt-c:execute(zsh -c 'eval \$FUNC_BODY; py-venv -c {q}; py-venv -a {q}; py-venv -i')+reload(ls $HOME/.venv)" \
      --bind "alt-r:execute-silent(zsh -c 'eval \$FUNC_BODY; py-venv -r {}')+reload(ls $HOME/.venv)")

  if [[ -n $out ]]; then
    py-venv -a $out
  fi
}

function py-venv() {
  local venv_dir=~/.venv

  case $1 in
  -l | --list)
    if [[ -d "$venv_dir" ]]; then
      echo -e "${COLOR_CYAN}Available virtual environments:${NC}"
      ls "$venv_dir"
    else
      echo -e "${COLOR_CYAN}No virtual environments found in $venv_dir.${NC}"
    fi
    ;;

  -a | --activate)
    if [[ -z "$2" ]]; then
      echo -e "${COLOR_CYAN}Error: Please specify a virtual environment to activate.${NC}"
      return 1
    fi

    local activate_script="$venv_dir/$2/bin/activate"
    if [[ -f "$activate_script" ]]; then
      source "$activate_script"
      echo -e "${COLOR_CYAN}Activated virtual environment: $2${NC}"
    else
      echo -e "${COLOR_CYAN}Error: Virtual environment '$2' does not exist.${NC}"
      return 1
    fi
    ;;

  -c | --create)
    if [[ -z "$2" ]]; then
      echo -e "${COLOR_CYAN}Error: Please specify a name for the new virtual environment.${NC}"
      return 1
    fi

    mkdir -p "$venv_dir"
    python3 -m venv "$venv_dir/$2"
    echo -e "${COLOR_CYAN}Created virtual environment: $2${NC}"
    ;;

  -r | --remove)
    if [[ -z "$2" ]]; then
      echo -e "${COLOR_CYAN}Error: Please specify a virtual environment to remove.${NC}"
      return 1
    fi

    if [[ -d "$venv_dir/$2" ]]; then
      rm -rf "$venv_dir/$2"
      echo -e "${COLOR_CYAN}Removed virtual environment: $2${NC}"
    else
      echo -e "${COLOR_CYAN}Error: Virtual environment '$2' does not exist.${NC}"
      return 1
    fi
    ;;

  -i | --install)
    if [[ -n $VIRTUAL_ENV ]]; then
      pip install pynvim pyright
    else
      echo -e "${COLOR_CYAN}ERROR: No virtual environment is loaded"
    fi
    ;;

  -h | --help)
    echo -e "${COLOR_CYAN}
	    Usage: py-venv [OPTION] [VENV_NAME]

	    Options:
	    -l, --list            List all virtual environments
	    -a, --activate VENV   Activate the specified virtual environment
	    -c, --create VENV     Create a new virtual environment
	    -r, --remove VENV     Remove (delete) the specified virtual environment
	    -i, --install	      Install common python libraries (pynvim, pyright)
	    -h, --help            Show this help message
	    ${NC}"
    ;;

  *)
    echo -e "${COLOR_CYAN}Error: Invalid option. Use 'py-venv --help' for usage information.${NC}"
    return 1
    ;;
  esac
}

