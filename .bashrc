# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

###############################
# CALOCOU BASH PROFILE 
###############################
HISTCONTROL=ignoredups
EDITOR=vim
# http://bashrcgenerator.com/
export PS1="\[\033[38;5;7m\]\u\[$(tput sgr0)\]\[\033[38;5;8m\]@\[$(tput sgr0)\]\[\033[38;5;44m\]\w\[$(tput sgr0)\]\[\033[38;5;9m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

##############################
# ALIASES 
##############################

# General aliases
alias reload_bashrc="source ~/.bashrc"
alias disable_system_beep="xset b 0 0"
alias toff="synclient TouchpadOff=1"
alias ton="synclient TouchpadOff=0"
alias coff="setxkbmap -option ctrl:nocaps"
alias con="setxkbmap -option"

# Movements
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Commands
alias ll="ls -altr --color"
alias ls="ls --color"
alias lr="ll -R "
alias cp="cp -rv "
alias grep='grep --color=auto'
alias h='history'
alias df="df -h"
alias mkcd='_(){ mkdir -pv $1; cd $1; }; _'

# tmux 256-colors
alias tmux="tmux -2"

# Mercurial aliases
alias log="hg log -l 8 -G"
alias commit="hg crecord"
alias reset="hg update -C"
alias stats="hg stat"

# Make aliases
alias conf_debug="./configure CFLAGS='-g -Wall -Wextra -O0 -Werror'"
alias conf_debug_migsp="./configure CFLAGS='-g -Wall -Wextra -O0 -DL_ENDIAN -DSTANDALONE'"
alias conf_debug_fence="./configure CFLAGS='-g -Wall -Wextra -O0 -lefence'"
alias conf_release="./configure CFLAGS='-DNDEBUG -O2 -s'"
alias remake="make clean && autoheader && automake && autoconf && conf_debug && make"
alias reconf="autoheader && automake && autoconf && conf_debug"
alias reconf_migsp="autoheader && automake && autoconf && conf_debug_ez"

# Valgrind aliases
alias valg="valgrind --tool=memcheck --leak-check=yes --show-reachable=yes --track-fds=yes"

# ACMF related
export CODA_DEFINITION="/mnt/work/ACMF/AcmfC/etc/AEOLUS-20150429.codadef"
export http_proxy="http://10.102.22.165:8080"
export https_proxy="https://10.102.22.165:8080"

# MIPAS related
export MIGSPHOME="/mnt/work/MIPAS/MIGSP"
export MICALHOME="/mnt/work/MIPAS/MICAL"


##############################
# FUNCTIONS
##############################
# FOR z.sh
. ~/.dotfiles/z.sh

alias pu="pushd '`pwd`'"
function pd()
{
    if [[ $# -ge 1 ]];
    then
        choice="$1"
    else
        dirs -v
        echo -n "? "
        read choice
    fi
    if [[ -n $choice ]];
    then
        declare -i cnum="$choice"
        if [[ $cnum != $choice ]];
        then #choice is not numeric
            choice=$(dirs -v | grep $choice | tail -1 | awk '{print $1}')
            cnum="$choice"
            if [[ -z $choice || $cnum != $choice ]];
            then
                echo "$choice not found"
                return
            fi
        fi
        choice="+$choice"
    fi
    pushd $choice
}

OpenAllMatchingFilesInVim() {
    find . -name "$1" -exec vim {} +
}
alias openall=OpenAllMatchingFilesInVim

#display directory tree structure
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"

# added by Anaconda2 2.4.1 installer
export PATH="/home/elwiss/anaconda2/bin:$PATH"
