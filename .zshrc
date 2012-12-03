#
# Example .zshrc file for zsh 4.0
#
# .zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#

# THIS FILE IS NOT INTENDED TO BE USED AS /etc/zshrc, NOR WITHOUT EDITING
# return 0	# Remove this line after editing this file as appropriate

# Search path for the cd command
#cdpath=(.. ~ ~/src ~/zsh)

# Use hard limits, except for a smaller stack and no core dumps
cd ~
unlimit
limit stack 8192
limit core 0
limit -s

umask 022

autoload zmv

# Set up aliases
alias -s {ogg,ogv,ogm,avi,mpeg,mpg,mov,m2v,mkv,wma,flv}=mpl
alias -s {odt,doc,sxw,rtf,xls}=openoffice.org
autoload -U pick-web-browser
alias -s {htm,html}=pick-web-browser
alias -s {pas,c,cpp,h}=vim
alias -s {pdf,djvu}=evince
alias -s {png,jpg,jpeg,bmp}=comix

alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias fortune='nocorrect fortune'
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias zcp="zmv -C"
alias zln="zmv -L"

# List only directories and symbolic
# links that point to directories
alias lsd='ls -ld *(-/DN)'

source $HOME/.she/init.sh

# Shell functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

# Where to look for autoloaded function definitions
fpath=($fpath ~/.zfunc)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g M='|most'
alias -g H='|head'
alias -g T='|tail'
alias -g G='|grep'
alias -g Gi='|grep -i'
alias -g ...="../.."
alias -g ....="../../.."
alias -g TMP='~/tmp'
alias -g BG='1,2>/dev/null &'
alias -g B='&|'

#manpath=(/usr/share/man $X11HOME/man /usr/man /usr/lang/man /usr/local/man)
#export MANPATH

# Hosts to use for completion (see later zstyle)
hosts=(`hostname` localhost 127.0.0.1)

# Set prompts
PROMPT='[%n][%T]:%~%# '    # default prompt
#PROMPTCHARS='$#'
SPROMPT="Ошибка! Вы хотели ввести %r вместо %R? ([Y]es/[N]o/[E]dit/[A]bort) "
#RPROMPT=' %~'     # prompt for right side of screen

# Some environment variables
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs


MAILCHECK=300
HISTSIZE=1000
SAVEHIST=1000
DIRSTACKSIZE=20

HISTFILE=~/.zhistory
# Watch for my friends
#watch=( $(<~/.friends) )       # watch for people in .friends file
watch=(notme)                   # watch for everybody but me
#LOGCHECK=300                    # check every 5 min for login/logout activity
WATCHFMT='%n %a %l from %m at %t.'

# Set/unset  shell options
setopt   APPEND_HISTORY
setopt   HIST_IGNORE_ALL_DUPS
setopt   HIST_REDUCE_BLANKS
setopt   HIST_IGNORE_SPACE
setopt   ignore_eof list_ambiguous
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent clobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning 
unsetopt bgnice autoparamslash flow_control autopushd pushdtohome

# Autoload zsh modules when they are referenced
#zmodload -a zsh/stat zstat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

# Some nice key bindings
#bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^X^A' vi-find-prev-char-skip
#bindkey '^Xa' _expand_alias
#bindkey '^Z' accept-and-hold
#bindkey -s '\M-/' \\\\
#bindkey -s '\M-=' \|

autoload .zkbd
source ~/.zkbd/$TERM
#### [[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
#### [[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
            # etc.
#vi mode modification
#bindkey -N myviins viins
#bindkey -N myvicmd vicmd

#function list_mappings(){bindkey}; zle -N list_mappings
#bindkey -M myvicmd ':map' list_mappings

#function my_viins_to_vicmd(){print -n "\033]0;zsh\a";bindkey -A myvicmd main}
#function my_vicmd_to_viinsi(){print -n "\033]0;zsh INSERT\a";bindkey -A myviins main}
#function my_vicmd_to_viinsa(){print -n "\033]0;zsh INSERT\a";zle vi-forward-char;bindkey -A myviins main}
#function my_vicmd_to_viinsA(){print -n "\033]0;zsh INSERT\a";zle vi-add-eol;bindkey -A myviins main}
#zle -N my_viins_to_vicmd
#zle -N my_vicmd_to_viinsi
#zle -N my_vicmd_to_viinsa
#zle -N my_vicmd_to_viinsA
#if [[ "$TERM" != "linux" ]]; then
  #bindkey -M myviins '^[' my_viins_to_vicmd
  #bindkey -M myvicmd 'i' my_vicmd_to_viinsi
  #bindkey -M myvicmd 'a' my_vicmd_to_viinsa
  #bindkey -M myvicmd 'A' my_vicmd_to_viinsA
#fi

#удаление n-ого параметра
killparam()
{
  zle beginning-of-line
  zle forward-word -n ${NUMERIC:-1} 
  zle delete-word -n 1
  zle vi-delete-char -n 1
  #zle my_vicmd_to_viinsi
}
zle -N killparam

#bindkey -M myvicmd 'q' killparam
#end

#[[ -n ${key[Insert]}   ]] && bindkey -M myvicmd "${key[Insert]}" yank
#[[ -n ${key[Delete]}   ]] && bindkey -M myvicmd "${key[Delete]}" delete-char
#[[ -n ${key[PageUp]}   ]] && bindkey -M myvicmd "${key[PageUp]}" up-line-or-history
#[[ -n ${key[PageDown]} ]] && bindkey -M myvicmd "${key[PageDown]}" down-line-or-history
#[[ -n ${key[Up]}       ]] && bindkey -M myvicmd "${key[Up]}" up-line-or-search ## up arrow for back-history-search
#[[ -n ${key[Down]}     ]] && bindkey -M myvicmd "${key[Down]}" down-line-or-search ## down arrow for fwd-history-search

#[[ -n ${key[Insert]}   ]] && bindkey -M myviins "${key[Insert]}" yank
#[[ -n ${key[Delete]}   ]] && bindkey -M myviins "${key[Delete]}" delete-char
#[[ -n ${key[PageUp]}   ]] && bindkey -M myviins "${key[PageUp]}" up-line-or-history
#[[ -n ${key[PageDown]} ]] && bindkey -M myviins "${key[PageDown]}" down-line-or-history
#[[ -n ${key[Up]}       ]] && bindkey -M myviins "${key[Up]}" up-line-or-search ## up arrow for back-history-search
#[[ -n ${key[Down]}     ]] && bindkey -M myviins "${key[Down]}" down-line-or-search ## down arrow for fwd-history-search

#bindkey -M myviins "\t" expand-or-complete #completition when tab pressed

#making work Home and End keys in both modes
#
#[[ -n ${key[Home]}   ]] && bindkey -M myviins "${key[Home]}" beginning-of-line 
#[[ -n ${key[End]}   ]] && bindkey -M myviins "${key[End]}" end-of-line

#[[ -n ${key[Home]}   ]] && bindkey -M myvicmd "${key[Home]}" beginning-of-line 
#[[ -n ${key[End]}   ]] && bindkey -M myvicmd "${key[End]}" end-of-line

bindkey -e                 # emacs key bindings
[[ -n ${key[Home]}    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n ${key[End]}     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n ${key[Insert]}  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n ${key[Delete]}  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n ${key[Left]}    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n ${key[Right]}   ]]  && bindkey  "${key[Right]}"   forward-char
[[ -n ${key[Backspace]}   ]]  && bindkey  "${key[Backspace]}"   backward-delete-char

[[ -n ${key[PageUp]}      ]]  && bindkey  "${key[PageUp]}"      up-line-or-history
[[ -n ${key[PageDown]}    ]]  && bindkey  "${key[PageDown]}"    down-line-or-history
[[ -n ${key[Up]}       ]] && bindkey "${key[Up]}" up-line-or-search ## up arrow for back-history-search
[[ -n ${key[Down]}     ]] && bindkey "${key[Down]}" down-line-or-search ## down arrow for fwd-history-search

#case $TERM in
#linux)
#bindkey -M myviins "\e[1~" beginning-of-line
#bindkey -M myviins "\e[4~" end-of-line
#bindkey -M myvicmd "\e[1~" beginning-of-line
#bindkey -M myvicmd "\e[4~" end-of-line
#;;
#*xterm*|rxvt|(dt|k|E)term)
#bindkey -M myviins "\e[H" beginning-of-line
#bindkey -M myviins "\e[F" end-of-line
#bindkey -M myvicmd "\e[H" beginning-of-line
#bindkey -M myvicmd "\e[F" end-of-line
#
#bindkey -M myviins "\e[OH" beginning-of-line
#bindkey -M myviins "\e[OF" end-of-line
#bindkey -M myvicmd "\e[OH" beginning-of-line
#bindkey -M myvicmd "\e[OF" end-of-line
#;;
#esac
#end vi mode modification



#bindkey -v               # vi key bindings

bindkey -e                 # emacs key bindings
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word 
#bindkey -A myviins main #mod vi insert  mode set
if [[ "$TERM" != "linux" ]]
  then
    print -n "\033]0;zsh\a" #print INSERT in title
  fi

# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -U compinit
compinit
zmodload zsh/complist
setopt menucomplete

# Completion Styles

# list of completers to use
#zstyle ':completion:*::::' completer _expand _complete _match _ignored _approximate

zstyle ':completion:*::::' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
#zstyle ':completion:*' completer _complete 


complete-files () { compadd - * }
zle -C complete complete-word complete-files
bindkey '^X\t' complete

zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' accept-exact false # veeeeeeeeeeeeeeeeery comfortable

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
#zstyle ':completion:*' menu yes select
#zstyle ':completion:*' menu yes select

zstyle ':completion:*' menu select=long-list select=0
bindkey -M menuselect "/" accept-and-infer-next-history
bindkey -M menuselect "^M" .accept-line
bindkey -M menuselect "\033[2~" accept-and-menu-complete
zstyle ':completion:*' old-menu false
zstyle ':completion:*' original true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*' word true

#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|[._-]=* r:|=*' 'm:{a-zA-Z}={A-Za-z} r:|[._-]=* r:|=*' 'm:{a-zA-Z}={A-Za-z} r:|[._-]=* r:|=*' 'm:{a-zA-Z}={A-Za-z} r:|[._-]=* r:|=*'

zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

#proccesses
zstyle ':completion:*:processes' command 'ps aux'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps xho command'

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

eval `dircolors ~/.dircolors`
zstyle ':completion:*:default' list-colors ${LS_COLORS} 

source ~/.mpl_zshcpl
