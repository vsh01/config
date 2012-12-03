#alias d1='ds 1'
#alias d2='ds 2'
#alias d3='ds 3'
#alias d4='ds 4'
#alias d5='ds 5'
#alias d6='ds 6'
#alias d7='ds 7'
#alias d8='ds 8'
#alias d9='ds 9'
#alias d0='ds 0'
alias dss='ds set'
alias dsl='ds list'
alias dsp='ds push'

if [ "$shell" = 'zsh' ]; then
_ds_list() {
    if [ -z "$XDG_CONFIG_HOME" ]; then
        config="$HOME"/.config/dir_links #directories
    else
        config="$XDG_CONFIG_HOME"/dir_links #directories
    fi
    n=0
    typeset -A ilist
    for i in "$config"/*; do
        if [ -d "$i" ]; then
            ilist[$n]="`basename $i`"
            let n=n+1
        fi
    done
    reply=($ilist) #zsh only
}

compctl -K _ds_list ds #zsh only
fi

if [ "$shell" = "bash" ]; then
    _ds_list() {
        if [ -z "$XDG_CONFIG_HOME" ]; then
            config="$HOME"/.config/dir_links #directories
        else
            config="$XDG_CONFIG_HOME"/dir_links #directories
        fi
        n=0
        for i in "$config"/*; do
            if [ -d "$i" ]; then
                ilist[$n]="`basename $i`"
                let n=n+1
            fi
        done
        COMPREPLY=(${ilist[*]}) #zsh only
    }
    complete -F _ds_list ds #zsh only
fi

ds()
{
    command=cd
    if [ "$1" = "push" ]; then
        command=pushd
        shift
    fi

    if [ -z "$XDG_CONFIG_HOME" ]; then
        config="$HOME"/.config/dir_links #directories
    else
        config="$XDG_CONFIG_HOME"/dir_links #directories
    fi
    if ! [ -d "$config" ]; then
        mkdir "$config"
    fi
    
    if [ -z "$1" ]; then
        for link in "$config"/*; do
            if ! [ -h "$link" ]; then
                continue
            fi
            dir="`readlink "$link"`"
            if [ "`basename "$link"`" = "list" ] || [ "`basename "$link"`" = "set" ]; then 
                rm -f "$link"
            fi
            echo "`basename "$link"`) $dir"
        done 2>/dev/null

        read ans
        if [ "$ans" = "" ]; then
            return
        fi

        if [ -h "$config/$ans" ]; then
            dir="`readlink "$config/$ans"`"
            if ! [ -d "$dir" ]; then
                echo "Directory is not exists"
                return
            fi
            $command "$dir"
        else
            echo "incorrect link"
        fi
        return 
    fi

    if [ "$1" = "set" ]; then
        if [ -z "$2" ]; then
            echo "Usage: `basename "$0"` set <link_name> [directory|null]"
            return
        fi
        link="$config/$2"

        if [ -z $3 ]; then
            dir="`pwd`"
        else
            dir="$3"
        fi

        if [ "$dir" = "null" ]; then
            rm -f "$link"
            return 
        fi

        if [ -h "$link" ]; then
            echo -n "Link already exists. You sure[Y/n] "
            read ans
            if [ "$ans" = "Y" ] || [ "$ans" = "y" ] || [ "$ans" = "" ]; then
                rm -f "$link"
            else
                return
            fi
        fi
        ln -s "$dir" "$link" 
        return 
    fi

    if [ "$1" = "list" ]; then
        for link in "$config"/*; do
            if ! [ -h "$link" ]; then
                continue
            fi
            dir="`readlink "$link"`"
            if [ "`basename "$link"`" = "list" ] || [ "`basename "$link"`" = "set" ]; then 
                rm -f "$link"
            fi
            echo "`basename "$link"`) $dir"
        done 2>/dev/null

        return
    fi

    link="$config/$1"
    if [ -h "$link" ]; then
        dir="`readlink "$link"`"
        if ! [ -d "$dir" ]; then
            echo "Directory is not exists"
            return
        fi
        $command "$dir"
    else
        echo "Incorrect link"
        return
    fi

}
