syntax on

" Setting basic style
set nocompatible
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
set ignorecase
set wildmode=longest,list,full


" Setup Vundle
" ------------
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin("~/.config/nvim/bundle")

Plugin 'VundleVim/Vundle.vim'

" Plugins

Plugin 'majutsushi/tagbar' " For tags
Plugin 'vim-airline/vim-airline' " Status Bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ycm-core/YouCompleteMe' " Completion Engine


Plugin 'SirVer/ultisnips' " Snippet Engine
Plugin 'Shougo/deoplete.nvim'
Plugin 'honza/vim-snippets' " Basic Snippet


call vundle#end()

" End Setup Plugins
" -----------------

" Setting Up Ultisnips
" --------------------

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Setting additionsel Directory

let g:UltiSnipsSnippetDirectories=["Ultisnips","my_snippets"]
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:deoplete#enable_at_startup = 1

filetype plugin indent on
let g:airline_theme='simple'


" Key Bindings
" ------------

nmap <F12> :NERDTreeToggle<Enter>
nmap <F11> :TagbarToggle<Enter>
