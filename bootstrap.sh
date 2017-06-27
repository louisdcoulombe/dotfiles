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

# Ctags
ls -s .dotfiles/ctags .ctags
