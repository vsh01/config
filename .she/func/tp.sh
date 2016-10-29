tp() {
    cmd=pushd
    if [ "$1" = "cd" ]; then
        cmd=cd
        tp_num=$2
    else
        tp_num=$1
    fi
    if [ -z "$tp_num" ]; then
        echo "Usage: tp <number>"
        return 1
    fi
    if ! [ -d "$HOME/work/jira/tp/$tp_num" ]; then
        echo -n "This will create new directory. Are you sure [Y/n] "
        read ans
        if [ "$ans" = "n" ]; then
            return 1
        fi
    fi
    mkdir -p $HOME/work/jira/tp/$tp_num
    $cmd $HOME/work/jira/tp/$tp_num
}

