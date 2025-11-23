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
alias neo='neofetch --ascii_distro kubuntu'
alias vimrc='v ~/.config/nvim/init.lua'
alias tmuxrc='nvim ~/.tmux.conf'
alias zshrc="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias killZombie="kill $(ps -A -ostat,ppid | awk '/[zZ]/{print $2}')"
alias killps="ps -ef | fzf | awk '{print $2}' | xargs kill"
alias weather='curl https://wttr.in'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias :q='exit'
# clear ; for t in "Wake up" "The Matrix has you" "Follow the white rabbit" "Knock, knock";do clear;pv -qL10 <<<$'\e[2J'$'\e[32m'$t$'\e[37m';sleep 5;done

alias SEAMCAT='/usr/local/java/jre1.8.0_411/bin/java -jar ~/Software/SEAMCAT-5.5.0-OFFICIAL.jar'

alias qr='qrencode -t ansiutf8'

alias gogh='bash -c "$(wget -qO- https://git.io/vQgMr)"'

alias gitinspector='/home/i2t/Git/gitinspector/gitinspector.py'

alias netinstall-cli='/home/i2t/ISOs/netinstall-7.18.2/netinstall-cli'
alias bat='batcat'

# DESKTOPINTEGRATION=0 $HOME/Software/marktext/marktext-x86_64.AppImage

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
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export EDITOR="nvim"

# This is the same functionality as fzf's ctrl-p, except that the file or
# directory selected is now automatically cd'ed or opened, respectively.
function fzf-open-file-or-dir() {
  local cmd="command find -L . \
    \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | sed 1d | cut -b3-"
  local out=$(eval $cmd | fzf-tmux --exit-0)

  if [ -f "$out" ]; then
    "$EDITOR" "$out" < /dev/tty
  elif [ -d "$out" ]; then
    cd "$out"
    zle reset-prompt
  fi
}

zle     -N   fzf-open-file-or-dir
bindkey '^P' fzf-open-file-or-dir

bindkey -s '^h' 'gocheat\n'

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

#compdef classroom

# zsh completion for classroom                            -*- shell-script -*-

__classroom_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_classroom()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16

    local lastParam lastChar flagPrefix requestComp out directive comp lastComp noSpace
    local -a completions

    __classroom_debug "\n========= starting completion logic =========="
    __classroom_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __classroom_debug "Truncated words[*]: ${words[*]},"

    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __classroom_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

    # For zsh, when completing a flag with an = (e.g., classroom -n=<TAB>)
    # completions must be prefixed with the flag
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        # We are dealing with a flag with an =
        flagPrefix="-P ${BASH_REMATCH}"
    fi

    # Prepare the command to obtain completions
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go completion code.
        __classroom_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __classroom_debug "About to call: eval ${requestComp}"

    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __classroom_debug "completion output: ${out}"

    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __classroom_debug "last line: ${lastLine}"

    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __classroom_debug "No directive found.  Setting do default"
        directive=0
    fi

    __classroom_debug "directive: ${directive}"
    __classroom_debug "completions: ${out}"
    __classroom_debug "flagPrefix: ${flagPrefix}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __classroom_debug "Completion received error. Ignoring completions."
        return
    fi

    local activeHelpMarker="_activeHelp_ "
    local endIndex=${#activeHelpMarker}
    local startIndex=$((${#activeHelpMarker}+1))
    local hasActiveHelp=0
    while IFS='\n' read -r comp; do
        # Check if this is an activeHelp statement (i.e., prefixed with $activeHelpMarker)
        if [ "${comp[1,$endIndex]}" = "$activeHelpMarker" ];then
            __classroom_debug "ActiveHelp found: $comp"
            comp="${comp[$startIndex,-1]}"
            if [ -n "$comp" ]; then
                compadd -x "${comp}"
                __classroom_debug "ActiveHelp will need delimiter"
                hasActiveHelp=1
            fi

            continue
        fi

        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}

            local tab="$(printf '\t')"
            comp=${comp//$tab/:}

            __classroom_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")

    # Add a delimiter after the activeHelp statements, but only if:
    # - there are completions following the activeHelp statements, or
    # - file completion will be performed (so there will be choices after the activeHelp)
    if [ $hasActiveHelp -eq 1 ]; then
        if [ ${#completions} -ne 0 ] || [ $((directive & shellCompDirectiveNoFileComp)) -eq 0 ]; then
            __classroom_debug "Adding activeHelp delimiter"
            compadd -x "--"
            hasActiveHelp=0
        fi
    fi

    if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
        __classroom_debug "Activating nospace."
        noSpace="-S ''"
    fi

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                # zsh requires a glob pattern to do file filtering
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"

        __classroom_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subdir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __classroom_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __classroom_debug "Listing directories in ."
        fi

        local result
        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        result=$?
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
        return $result
    else
        __classroom_debug "Calling _describe"
        if eval _describe "completions" completions $flagPrefix $noSpace; then
            __classroom_debug "_describe found some completions"

            # Return the success of having called _describe
            return 0
        else
            __classroom_debug "_describe did not find completions."
            __classroom_debug "Checking if we should do file completion."
            if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
                __classroom_debug "deactivating file completion"

                # We must return an error code here to let zsh know that there were no
                # completions found by _describe; this is what will trigger other
                # matching algorithms to attempt to find completions.
                # For example zsh can match letters in the middle of words.
                return 1
            else
                # Perform file completion
                __classroom_debug "Activating file completion"

                # We must return the result of this command, so it must be the
                # last command, or else we must store its result to return it.
                _arguments '*:filename:_files'" ${flagPrefix}"
            fi
        fi
    fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_classroom" ]; then
    _classroom
fi
