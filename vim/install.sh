#!/bin/sh

mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/init.vim

if [ ! -d ~/.config/nvim/bundle ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
fi
