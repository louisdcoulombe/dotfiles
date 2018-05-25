#!/bin/bash

cd ~

# Bashrc
rm .bashrc
ln -s .dotfiles/.bashrc .bashrc

# hgrc
ln -s .dotfiles/.hgrc .hgrc

# tmux
ln -s .dotfiles/.tmux.conf .tmux.conf

# Vim
ln -s .dotfiles/.vimrc .vimrc
git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
