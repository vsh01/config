# Use hard limits, except for a smaller stack and no core dumps
cd ~
unlimit
limit stack 8192
limit core 0
limit -s

umask 022

autoload zmv

alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias zcp="zmv -C"
alias zln="zmv -L"

# List only directories and symbolic
# links that point to directories
alias lsd='ls -ld *(-/DN)'

source $HOME/.she/init.sh

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g H='|head'
alias -g T='|tail'
alias -g G='|grep'
alias -g Gi='|grep -i'
alias -g BG='1,2>/dev/null &'
alias -g B='&|'

# Set prompts
PROMPT='[%n@%m][%T]:%~%# '    # default prompt
SPROMPT="Ошибка! Вы хотели ввести %r вместо %R? ([Y]es/[N]o/[E]dit/[A]bort) "

MAILCHECK=300
HISTSIZE=1000
SAVEHIST=1000
DIRSTACKSIZE=20

HISTFILE=~/.zhistory

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
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

autoload .zkbd
source ~/.zkbd/$TERM

#удаление n-ого параметра
killparam()
{
  zle beginning-of-line
  zle forward-word -n ${NUMERIC:-1} 
  zle delete-word -n 1
  zle vi-delete-char -n 1
}
zle -N killparam

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

bindkey -e                 # emacs key bindings
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word 


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
zstyle ':completion:*::::' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix

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

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

eval `dircolors ~/.dircolors`
zstyle ':completion:*:default' list-colors ${LS_COLORS} 

