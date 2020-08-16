#!/bin/bash
# In .bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# To support emacs and byobu
export TERM=xterm-256color

PARENTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/../ && pwd )"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# BASH HISTORY
export HISTSIZE=10000
export HISTFILESIZE=100000
export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
shopt -s histappend
# Combine multiline commands into one in history
shopt -s cmdhist
# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# $PS1 customization
RED='\[\e[31m\]'
GREEN='\[\e[32m\]'
BROWN='\[\e[33m\]'
BLUE='\[\e[34m\]'
MAGENTA='\[\e[35m\]'
CYAN='\[\e[36m\]'
LIGHT_YELLOW='\[\e[93m\]'
NORMAL='\[\e[0m\]'

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_DESCRIBE_STYLE=branch
source /usr/lib/git-core/git-sh-prompt
GIT_STRING='$(__git_ps1 " (%s)")'

# END_CHARACTER=$'\u26A1 >' # Lightning
END_CHARACTER='\$ >'
test -f /.dockerinit && END_CHARACTER='&'

PS1="\n${RED}\u${BROWN}@\H ${LIGHT_YELLOW}\w${CYAN}${GIT_STRING}\n${RED}${END_CHARACTER} ${NORMAL}"
export PS1

# apt commands
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get update && sudo apt-get upgrade'

# cd improvements
alias cd..='cd ../' # Go back 1 directory level (for fast typers)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .3='cd ../../../'    # Go back 3 directory levels
alias .4='cd ../../../../' # Go back 4 directory levels

# ls improvements
alias ls='ls -F --color=auto'
alias ll='ls -hl'
alias lla='ls -ahl'

# Make these commands ask before clobbering a file. Use -f to override.
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# git improvements
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gbv='git branch -vv'
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias go='git checkout'
alias gco='git checkout'
alias gl='git log --all --graph --decorate --oneline'
alias p='git pull'
alias gp='git push'
alias gm='git merge'
alias gr='git remote'
alias grv='git remote -vv'

alias gk='gitk --all&'
alias gx='gitx --all'

# Wifi commands
alias rwifi="nmcli r wifi off && nmcli r wifi on"
alias cw="nmcli c up"
alias cwslasher="nmcli c up 'Slasher'"
alias cwdelta="nmcli c up 'DELTA 5G'"

alias ticks="echo '\`\`' | xclip -selection c; echo 'Backticks copied to clipboard'"
alias p8='ping 8.8.8.8'

# Device specifics
alias gpu="lspci -vnnn | perl -lne 'print if /^\d+\:.+(\[\S+\:\S+\])/' | grep VGA"
alias backlight="sudo xmodmap -e 'add mod3 = Scroll_Lock'"

# Execs
alias pymusic="cd ~/code/pyMusic/py_music && python3 main.py"
alias :q="exit"

# Autocomplete for 'g' as well
complete -o default -o nospace -F _git g

#Functions
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       rar x $1       ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function swap() {
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

mkcd() {
    if [ $# != 1 ]; then
        echo "Usage: mkcd <dir>"
    else
        mkdir -p $1 && cd $1
    fi
}

lsg() {
    if [ $# == 1 ]; then
        ls -a | grep $1
    elif [ $# == 2 ]; then
        ls -a $1 | grep $2
    else
        echo "Error: enter 1 | 2 argument/s"
    fi
}

title="
    ██████╗  █████╗ ███████╗██╗  ██╗    
    ██╔══██╗██╔══██╗██╔════╝██║  ██║    
    ██████╔╝███████║███████╗███████║    
    ██╔══██╗██╔══██║╚════██║██╔══██║    
    ██████╔╝██║  ██║███████║██║  ██║    
    ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝slash
"

echo -ne "\e[35m"
echo "${title}"
