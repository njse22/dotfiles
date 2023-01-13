alias gr="grep --exclude-dir=build --exclude-dir=swig --exclude-dir=.git --exclude=tags -rniI "
alias v=openNvim
alias vr='nvim -R'
alias vf='nvim $(fzf --height 50% --reverse --border --preview "batcat --style=numbers --color=always --line-range :500 {}")'
alias psf='ps -ef | fzf --height 50% --reverse --border'
alias hyf='history | fzf --height 50% --reverse --border'
alias lt='tree'
alias cl='clear'
alias neo='neofetch --ascii_distro kubuntu'
alias vimrc='nvim ~/.config/nvim/init.vim'
alias tmuxrc='nvim ~/.tmux.conf'
alias zshrc="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias killZombie="kill $(ps -A -ostat,ppid | awk '/[zZ]/{print $2}')"
alias killps="ps -ef | fzf | awk '{print $2}' | xargs kill -9"
alias weather='curl https://wttr.in'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# clear ; for t in "Wake up" "The Matrix has you" "Follow the white rabbit" "Knock, knock";do clear;pv -qL10 <<<$'\e[2J'$'\e[32m'$t$'\e[37m';sleep 5;done

function openNvim {
    if [[ $# -eq 0 ]]; then
        nvim ./
    else
        nvim $1
    fi
}

# This is the same functionality as fzf's ctrl-p, except that the file or
# directory selected is now automatically cd'ed or opened, respectively.
fzf-open-file-or-dir() {
  local cmd="command find -L . \
    \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | sed 1d | cut -b3-"
  local out=$(eval $cmd | fzf-tmux --exit-0)

  if [ -f "$out" ]; then
    $EDITOR "$out" < /dev/tty
  elif [ -d "$out" ]; then
    cd "$out"
    zle reset-prompt
  fi
}
zle     -N   fzf-open-file-or-dir
bindkey '^P' fzf-open-file-or-dir

