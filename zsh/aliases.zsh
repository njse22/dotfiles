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

## UPDATE PATH VARIABLE 
export PATH="$GOPATH/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.local/bin

#######################################################################
#                            CUSTOM ALIAS                             #
#######################################################################

alias gr="grep --exclude-dir=build --exclude-dir=swig --exclude-dir=.git --exclude=tags -rniI "
alias v='nvim'
alias vr='nvim -R'
alias vf='nvim $(fzf --height 50% --reverse --border --preview "batcat --style=numbers --color=always --line-range :500 {}")'
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
function neo(){
    clear ; 
    for t in "Wake up..." "The Matrix has you..." "Follow the white rabbit." "Knock, knock."; do 
	clear;pv -qL10 <<<$'\e[2J'$'\e[32m'$t$'\e[37m';sleep 5;
    done; 
    cmatrix
}

# This is the same functionality as fzf's ctrl-t, except that the file or
# directory selected is now automatically cd'ed or opened, respectively.
function fzf-open-file-or-dir() {
    zle -I 

    local show_preview='
    if [ -f {} ]; then 
	batcat -n --color=always {}
    elif [ -d {} ]; then
	tree -C {}
	fi'

	local menu_string="
	${COLOR_YELLOW}
	[            Menu Options            ]
	${NC}
	${COLOR_CYAN}
	1. CTRL - /  : Toggle Layouth
	2. ALT - D   : Create Directory
	3. ALT - F   : Create File
	4. CTRL - A  : Search All
	5. CTRL - D  : Search Only Directories
	6. CTRL - F  : Search Only Files 
	7. ESC	     : Exit 
	${NC}"

	local cmd="command find -L . \
	    \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
	    -o -type f -print \
	    -o -type d -print \
	    -o -type l -print 2> /dev/null | sed 1d | cut -b3-"

	local out=$(eval $cmd | 
	    fzf  \
	    --style full \
	    --pointer='→' \
	    --walker-skip .git,node_modules,target \
	    --preview-window 45% \
	    --preview "$show_preview" \
	    --bind "?:preview:echo '$menu_string'" \
	    --bind 'ctrl-/:change-preview-window(down|hidden|)' \
	    --bind "alt-d:execute(mkdir -p {q})+reload($cmd)" \
	    --bind "alt-f:execute-silent(touch {q})+reload($cmd)" \
	    --bind "ctrl-a:change-prompt(Search> )+reload($cmd)" \
	    --bind 'ctrl-d:change-prompt(Directories> )+reload(find * -type d -maxdepth 3)' \
	    --bind 'ctrl-f:change-prompt(Files> )+reload(find * -type f)' \
	    --header 'Press ? to toggle menu' 
	)

	if [ -f "$out" ]; then
	    "$EDITOR" "$out" < /dev/tty
	elif [ -d "$out" ]; then
	    BUFFER="cd $out"
	    CURSOR=$#BUFFER
	    zle reset-prompt
	fi
    }

zle     -N   fzf-open-file-or-dir
bindkey '^P' fzf-open-file-or-dir

# git --help -a | grep -E '^\s+' | fzf --style full --bind 'enter:execute( echo -n {} | awk '\''{print "git " $1}'\'' )+abort'
#
_fzf_complete_git() {
    _fzf_complete -- "$@" < <(
	git --help -a | grep -E '^\s+' | awk '{print $1}'
    )
}

function __fzf_git_helper(){
    zle -I 

    local command=$( git --help -a | grep -E '^\s+' | fzf --style full | awk '{print $1}') 

    if [[ -n "$command" ]]; then 
	BUFFER="git $command "
    fi
    CURSOR=$#BUFFER

    zle reset-prompt
}

zle     -N   __fzf_git_helper
bindkey '^g' __fzf_git_helper

function __fzf_py_env(){
    local venv_dir=$HOME/.venv
    local opt=$(functions py-venv)

    local out=$(ls $venv_dir | 
	FUNC_BODY="$opt" fzf \
	--tmux 60% \
	--pointer ▶ \
	--border-label ' py-venv (Helper to python envioroments) ' --input-label ' Input ' \
	--header 'Press ALT-C (create) / ALT-R (remove) / ENTER (activate)' \
	--bind "alt-c:execute(zsh -c 'eval \$FUNC_BODY; py-venv -c {q}; py-venv -a {q}; py-venv -i')+reload(ls $HOME/.venv)" \
	--bind "alt-r:execute-silent(zsh -c 'eval \$FUNC_BODY; py-venv -r {}')+reload(ls $HOME/.venv)" )

    if [[ -n $out ]]; then
	py-venv -a $out
    fi
}

function py-venv() {
    local venv_dir=~/.venv

    case $1 in
	-l|--list)
	    if [[ -d "$venv_dir" ]]; then
		echo -e "${COLOR_CYAN}Available virtual environments:${NC}"
		ls "$venv_dir"
	    else
		echo -e "${COLOR_CYAN}No virtual environments found in $venv_dir.${NC}"
	    fi
	    ;;

	-a|--activate)
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

	-c|--create)
	    if [[ -z "$2" ]]; then
		echo -e "${COLOR_CYAN}Error: Please specify a name for the new virtual environment.${NC}"
		return 1
	    fi

	    mkdir -p "$venv_dir"
	    python3 -m venv "$venv_dir/$2"
	    echo -e "${COLOR_CYAN}Created virtual environment: $2${NC}"
	    ;;

	-r|--remove)
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

	-i|--install)
	    if [[ -n $VIRTUAL_ENV ]]; then
		pip install pynvim pyright
	    else
		echo -e "${COLOR_CYAN}ERROR: No virtual environment is loaded"
	    fi
	    ;;

	-h|--help)
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

