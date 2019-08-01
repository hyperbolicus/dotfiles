#!/bin/sh

brew install zsh
brew tap homebrew/cask-fonts
brew install homebrew/cask-fonts/font-dejavu-sans-mono-for-powerline

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Cloning oh my zsh"
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  chsh -s /bin/zsh
else
  echo ".oh-my-zsh found. Does not install"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel9k" ]; then
  git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k
fi

## Moving zshrc
cp zshrc ~/.zshrc
