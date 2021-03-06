" Никогда не юзай set nobackup  (я это написал после того как удалил час
" работы)
"Plugins
"Plug - https://github.com/junegunn/vim-plug
"Command to download:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
"Plug 'scrooloose/syntastic'
call plug#end()


if has('gui_running')
    set gfn=Roboto\ Mono\ Light\ for\ Powerline\ Semi-Light\ 14
    colo industry
endif


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
set listchars=tab:▸·,trail:·,eol:¬,precedes:«,extends:»
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
set hlsearch
set laststatus=2
set nomodeline
set showcmd


"airline
" Need fonts from https://github.com/powerline/fonts, comment if fonts not
" used
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "dark"

set noshowmode

"syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = '/usr/bin/python3'
