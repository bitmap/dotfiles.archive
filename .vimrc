if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'

call plug#end()

" utf-8
set encoding=utf-8

" enter the current millennium
set t_Co=256
set termguicolors
set nocompatible

" pretty
syntax enable
colorscheme codedark

" enable syntax and plugins
filetype plugin on

" load filetype-specific indent files
filetype indent on

" rad tab-completion
set path+=**
set wildmenu

" INSERT tweaks
set esckeys
set backspace=indent,eol,start

" enable mouse
set mouse=a

" fix annoying cursor hop
set nostartofline
set ruler

" always show mode
set showmode
set showcmd

" highlight matching brackets
set showmatch

" show filename
set title

" show line numbers and highlight line
set number
set cursorline

" map system keyboard to paster buffer
set clipboard=unnamedplus

" make tabs as wide as two spaces
set expandtab
set tabstop=2
set softtabstop=2

" redraw only when we need to.
set lazyredraw

" cursor shape
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" status line
let g:airline_theme = 'codedark'
set laststatus=2
set noshowmode

" set undo directory
set undodir=~/.vim/undo

" remap Esc to jj
inoremap jj <ESC>
