alias j=jobs
alias h=history
alias grep=egrep

alias tmux="TERM=screen-256color tmux"

alias ls='ls --color=auto --group-directories-first'
alias l='ls -l'
alias lh='ls -lh'
alias la='ls -a'
# List only file beginning with "."
alias lsa='ls -ld .*'

alias cal='ncal -b'


alias df='df -h'
alias du='du -h'

alias mkpass="head -c4 /dev/urandom | xxd -ps"

alias kill9="kill -9"

alias trs='transmission-show'


#apt aliases
alias apts="apt-cache show"
alias aptp="apt-cache policy"
alias aptss="apt-cache search"
alias apti="sudo apt-get install"
alias aptu="sudo apt-get update"
alias aptd="sudo apt-get dist-upgrade"
alias aptg="sudo apt-get upgrade"
alias aptr="sudo apt-get remove"

#directories
alias p=pushd
alias pp='pushd ~'
alias p1='pushd +0'
alias po=popd
alias d='dirs -v'
alias 0='echo ~0;ls ~0'
alias 1='echo ~1;ls ~1'
alias 2='echo ~2;ls ~2'
alias 3='echo ~3;ls ~3'
alias 4='echo ~4;ls ~4'
alias 5='echo ~5;ls ~5'
alias 6='echo ~6;ls ~6'
alias 7='echo ~7;ls ~7'
alias 8='echo ~8;ls ~8'
alias 9='echo ~9;ls ~9'
