" pretty
syntax enable
set background=dark
colorscheme base16-default-dark

" enter the current millennium
set nocompatible

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

" status line
" set laststatus=2

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

" make tabs as wide as two spaces
set expandtab
set tabstop=2
set softtabstop=2

" redraw only when we need to.
set lazyredraw
