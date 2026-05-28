alias tree='tree -a -I .git'
alias reload="exec zsh"

alias v=nvim
alias g=git
alias c=claude

# Movements
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Commands
alias ll="ls -altr --color"
alias ls="ls --color"
alias lr="ll -R "
alias cp="cp -irv "
alias rm="rm -v "
alias mv="mv -v"
alias grep='grep --color=auto'
alias h='history'
alias df="df -h"
alias take='_(){ mkdir -pv $1; cd $1; }; _'
alias vi="nvim"
alias del="rm -rf"
