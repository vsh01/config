"Plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/syntastic'
call plug#end()


set background=dark
set t_Co=256

set nocompatible
set backspace=indent,eol,start
set nowrap

filetype indent plugin on
syntax on


set smartcase


set number
set relativenumber
"Display unprintable symbols
set listchars=tab:▸·,space:·,eol:¬,precedes:«,extends:»
set list
"Indents
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent

map <F1> :NERDTreeToggle<CR>
imap <F1> <ESC><ESC>:NERDTreeToggle<CR>

"Other
set wildmenu
set nobackup
set hlsearch
set laststatus=2
set nomodeline


"airline
" Need fonts from https://github.com/powerline/fonts, comment if fonts not
" used  
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "dark"

set noshowmode
