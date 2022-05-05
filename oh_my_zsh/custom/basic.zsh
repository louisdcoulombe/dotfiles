# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

# For example: add yourself some shortcuts to projects you often work on.
#
# brainstormr=~/Projects/development/planetargon/brainstormr
# cd $brainstormr
#

alias reload="source ~/.zshrc"

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
alias mkcd='_(){ mkdir -pv $1; cd $1; }; _'
alias vi="vim"
alias del="rm -rf"

alias python="python3.8"
alias p="python"
alias pvenv="python -m venv venv"
alias pac="source ./venv/bin/activate"

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
