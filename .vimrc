set nocompatible

let mapleader = ","
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set nowrap


"{{{ Appearance
set t_Co=256
colo Laravel
set background=dark
"if has("gui_running")
    "if has("gui_gtk2")
        "set guifont=Terminus\ 14
    "else
        "set guifont="-*-terminus-medium-r-normal--14-*-*-*-*-*-iso10646-1"
    "endif
    "set guioptions-=T
"else
"endif

"if has('gui')
    "if has('win32')
        "au GUIEnter * call libcallnr('maximize', 'Maximize', 1)
    "elseif has('gui_gtk2')
        "au GUIEnter * :set lines=99999 columns=99999
    "endif
"endif
"set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P
"}}}

set ignorecase
set autoindent	" always set autoindenting on
set showmatch
set number

set smartindent
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set listchars=tab:··
set list

set nobackup		" keep a backup file
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" show partial command in status line

" uset noeightbitmeta	" Meta-Sends-Escape
set foldmethod=marker
set hlsearch
set viminfo='50,r/mnt/floppy,r/mnt/zip,%,n~/.viminfo
set fileencodings=ucs-bom,utf8,cp1251,koi8r
set encoding=utf8
set nrformats=octal,hex,alpha

syntax on

" Визуальное ограничение в 80 символов
"highlight TooLongLine term=reverse ctermfg=Yellow ctermbg=Red
"match TooLongLine /.\%>81v/

"{{{ Mapping
" Don't use Ex mode, use Q for formatting
map Q gq

map <F1> :NERDTreeToggle<CR>
imap <F1> <ESC><ESC>:NERDTreeToggle<CR>
"vmap <F1> <ESC><ESC>:NERDTreeToggle<CR> 

map <F8> :TlistToggle<CR>
imap <F8> <ESC><ESC>:TlistToggle<CR>a
"vmap <F8> <ESC><ESC>:TlistToggle<CR>i 

map <C-D>o :copen<CR>
map <C-D>c :cclose<CR>
"imap <C-D>o <ESC>:copen<CR>
"imap <C-D>c <ESC>:cclose<CR>

"build and run
map <F2> :w<CR>
imap <F2> <ESC>:w<CR>a
map <F9> :make<CR>
map <F5> :!./%<<CR>
map <S-F5> :!./%< <input >output<CR>
"imap <F9> <ESC>:!g++ % -o %<<CR>

"save and exit
map <F10> :qa<CR>
map <C-F10> :qa!<CR>

"work with buffers
map <F12> <ESC>:bn<CR>
imap <F12> <ESC>:bn<CR>
map <F11> <ESC>:bp<CR>
imap <F11> <ESC>:bp<CR>

"work with tabs
map <Leader>tn :tabnew<CR>
map <Leader>tt :tabnext<CR>   
map <Leader>tp :tabprevious<CR>   

nmap <F3> :nohlsearch<CR>
imap <F3> <Esc>:nohlsearch<CR>
vmap <F3> <Esc>:nohlsearch<CR>gv

"imap <Tab> <C-N>

nmap <Home> ^
imap <Home> <Esc>I

" окно выше
map <C-K> <C-W>k
imap <C-K> <C-o><C-K>

" окно левее
map <C-L> <C-W>l
imap <C-L> <C-o><C-L>

" окно правее
map <C-H> <C-W>h
imap <C-H> <C-o><C-H>

" окно ниже
let g:C_Ctrl_j = 'off'
nnoremap <C-J> <C-W>j
imap <C-J> <C-o><C-J>

map <Leader>dd yy[pI// {{{ <Esc>jj%o// }}}<Esc>zcjj
" Умный home
nmap <silent><Home> :call SmartHome("n")<CR>
imap <silent><Home> <C-r>=SmartHome("i")<CR>
vmap <silent><Home> <Esc>:call SmartHome("v")<CR>
"}}}

" {{{ Encodings menu (not use at now
set  wildmenu
set  wcm=<Tab>
menu Enc.utf-8     :e ++enc=utf-8<CR>
menu Enc.cp1251    :e ++enc=cp1251<CR>
menu Enc.koi8-r    :e ++enc=koi8-r<CR>
menu Enc.cp866     :e ++enc=ibm866<CR>
menu Enc.ucs-2le   :e ++enc=ucs-2le<CR>
map  <C-D>m :emenu Enc.<TAB>
" }}}


"{{{ CCodeEdit
function CCodeEdit()
    "imap { {}<LEFT>
    "imap {} {}
    "imap ( ()<LEFT>
    "imap () ()

    "imap /* /**/<LEFT><LEFT>
    "imap /**/ /**/

    "imap ' ''<LEFT>
    "imap '' ''
    "imap " ""<LEFT>
    "imap "" ""

    "imap ;; <END>;<CR>

    "imap {{ <END>{<CR><CR><UP><TAB>
    "imap [ <END><CR>{{
    setlocal foldlevelstart=99
    "setlocal foldmethod=syntax
endfunction
"}}}

function PyCodeEdit()
    highlight TooLongLine term=reverse ctermfg=Black ctermbg=White
    match TooLongLine /.\%>81v/
endfunction

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on
    autocmd filetype c call CCodeEdit()
    autocmd filetype python call PyCodeEdit()
    autocmd BufNewFile,BufRead *.svg setf svg 

endif " has("autocmd")

" Disable 'title' and 'icon' features in terminal modes in order to
" avoid timeouts on startup (caused by attempts to connect to X server.
" For GUI version we'll reenable them in gvimrc.
if has("title")
    set notitle
    set noicon
endif

function ModeChange()
    if getline(1) =~ "^#!"
        if getline(1) =~ "/bin/"
            silent !chmod a+x "<afile>"
        endif
    endif
endfunction
au BufWritePost * call ModeChange()

" Disabled for security reasons
set nomodeline

function SmartHome(mode)
    let curcol = col(".")
    "gravitate towards beginning for wrapped lines
    if curcol > indent(".") + 2
        call cursor(0, curcol - 1)
    endif
    if curcol == 1 || curcol > indent(".") + 1
        if &wrap
            normal g^
        else
            normal ^
        endif
    else
        if &wrap
            normal g0
        else
            normal 0
        endif
    endif
    if a:mode == "v"
        normal msgv`s
    endif
    return ""
endfunction
