#!/bin/sh

mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/init.vim

# Snippets
mkdir -p ~/.config/nvim/my_snippets
cp my_snippets/* ~/.config/nvim/my_snippets

if [ ! -d ~/.config/nvim/bundle ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
fi

nvim +PluginInstall +qall
cp ctags ~/.ctags

cd ~/.config/nvim/bundle/YouCompleteMe
./install.py --go-completer --rust-completer

cd -
