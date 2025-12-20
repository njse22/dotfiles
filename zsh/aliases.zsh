# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

PLACES="~/snap/firefox/common/.mozilla/firefox/1ygk70ql.default/places.sqlite"
TEMP="$HOME/.config/places.sqlite"

alias gr="grep --exclude-dir=build --exclude-dir=swig --exclude-dir=.git --exclude=tags -rniI "
alias v='nvim'
alias vr='nvim -R'
alias vf='nvim $(fzf --height 50% --reverse --border --preview "batcat --style=numbers --color=always --line-range :500 {}")'
alias psf='ps -ef | fzf --height 50% --reverse --border'
# alias hyf='history | fzf --height 50% --reverse --border'
alias hyf='history | fzf --height 50% --reverse --border | sed "s/^[ ]*[0-9]*[ ]*//" | xargs -I {} zsh -c "{}"'
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

# clear ; for t in "Wake up" "The Matrix has you" "Follow the white rabbit" "Knock, knock";do clear;pv -qL10 <<<$'\e[2J'$'\e[32m'$t$'\e[37m';sleep 5;done

alias SEAMCAT='/usr/local/java/jre1.8.0_411/bin/java -jar ~/Software/SEAMCAT-5.5.0-OFFICIAL.jar'

alias qr='qrencode -t ansiutf8'

alias gogh='bash -c "$(wget -qO- https://git.io/vQgMr)"'

alias gitinspector='/home/i2t/Git/gitinspector/gitinspector.py'

alias netinstall-cli='/home/i2t/ISOs/netinstall-7.18.2/netinstall-cli'

alias bat='batcat'

function openNvim {
    if [[ $# -eq 0 ]]; then
        nvim ./
    else
        nvim $1
    fi
}

function simon() {
    python3 ~/Git/Programa-estrategico/simon/src/run.py
}

function simona() {
    cd ~/Git/Programa-estrategico/simona/ && npm run dev && cd ~
}

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --style full
  --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_CTRL_T_OPTS="
  --style full 
  --walker-skip .git,node_modules,target
  --preview 'batcat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  "

export EDITOR="nvim"

# This is the same functionality as fzf's ctrl-p, except that the file or
# directory selected is now automatically cd'ed or opened, respectively.
function fzf-open-file-or-dir() {
    zle -I 

    local cmd="command find -L . \
	\\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
	-o -type f -print \
	-o -type d -print \
	-o -type l -print 2> /dev/null | sed 1d | cut -b3-"

      local out=$(eval $cmd | 
	fzf  \
	    --style full \
	    --walker-skip .git,node_modules,target \
	    --preview '
		       if [ -f {} ]; then 
			   batcat -n --color=always {}
			elif [ -d {} ]; then
			    tree -C {}
			fi
		       ' \
	    --bind 'ctrl-/:change-preview-window(down|hidden|)' )

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

function update-bookmark(){
  echo "Copying file:"
  echo "> $PLACES"
  echo "To: $TEMP"
  cp "$PLACES" "$TEMP"
  echo "Copied! Exiting..."
}

function firefox-bookmarks(){

    # https://cp737.net/blog/quick-find-firefox-bookmarks
    
    bk="$(sqlite3 $TEMP "SELECT h.url, b.title
    FROM moz_places h
    JOIN moz_bookmarks b
    ON h.id = b.fk;" | fzf)"

    if [ ! -z "$bk" ]; then
      firefox "$(echo "$bk" | cut -d"|" -f1 )"
    fi
}

function py-venv() {
    local venv_dir=~/.venv

    case $1 in
        -l|--list)
            if [[ -d "$venv_dir" ]]; then
                echo -e "${CYAN}Available virtual environments:${NC}"
                ls "$venv_dir"
            else
                echo -e "${CYAN}No virtual environments found in $venv_dir.${NC}"
            fi
            ;;

        -a|--activate)
            if [[ -z "$2" ]]; then
                echo -e "${CYAN}Error: Please specify a virtual environment to activate.${NC}"
                return 1
            fi

            local activate_script="$venv_dir/$2/bin/activate"
            if [[ -f "$activate_script" ]]; then
                source "$activate_script"
                echo -e "${CYAN}Activated virtual environment: $2${NC}"
            else
                echo -e "${CYAN}Error: Virtual environment '$2' does not exist.${NC}"
                return 1
            fi
            ;;

        -c|--create)
            if [[ -z "$2" ]]; then
                echo -e "${CYAN}Error: Please specify a name for the new virtual environment.${NC}"
                return 1
            fi

            mkdir -p "$venv_dir"
            python3 -m venv "$venv_dir/$2"
            echo -e "${CYAN}Created virtual environment: $2${NC}"
            ;;

        -r|--remove)
            if [[ -z "$2" ]]; then
                echo -e "${CYAN}Error: Please specify a virtual environment to remove.${NC}"
                return 1
            fi

            if [[ -d "$venv_dir/$2" ]]; then
                rm -rf "$venv_dir/$2"
                echo -e "${CYAN}Removed virtual environment: $2${NC}"
            else
                echo -e "${CYAN}Error: Virtual environment '$2' does not exist.${NC}"
                return 1
            fi
            ;;

        -h|--help)
            echo -e "${CYAN}
            Usage: py-venv [OPTION] [VENV_NAME]

            Options:
                -l, --list            List all virtual environments
                -a, --activate VENV   Activate the specified virtual environment
                -c, --create VENV     Create a new virtual environment
                -r, --remove VENV     Remove (delete) the specified virtual environment
                -h, --help            Show this help message
            ${NC}"
            ;;

        *)
            echo -e "${CYAN}Error: Invalid option. Use 'py-venv --help' for usage information.${NC}"
            return 1
            ;;
    esac
}

