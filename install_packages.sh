#!/bin/bash
set -e

sudo apt-get install git vim tmux zsh curl

# for pyenv
sudo apt-get install -y make build-essential \
                        libssl-dev zlib1g-dev libbz2-dev \
                        libreadline-dev libsqlite3-dev \
                        wget curl llvm \
                        libncurses5-dev libncursesw5-dev \
                        xz-utils tk-dev
