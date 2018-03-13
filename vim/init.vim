syntax on

" Setting basic style
set nocompatible
set number
set relativenumber
set showmode
set smartcase
set smarttab
set smartindent
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set background=dark
set laststatus=0

" Setup Vundle
" ------------
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin("~/.config/nvim/bundle")

Plugin 'VundleVim/Vundle.vim'

" Plugins

Plugin 'scrooloose/nerdtree' " File tab
Plugin 'vim-syntastic/syntastic' " Language Description
Plugin 'majutsushi/tagbar' " For tags

call vundle#end()

" End Setup Plugins
" -----------------


filetype plugin indent on
