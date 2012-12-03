if [ "$shell" = "zsh" ]; then
    _ms_list() {
        reply=($(mpc lsplaylists)) #zsh only
    }

    compctl -K _ms_list ms #zsh only
fi

if [ "$shell" = "bash" ]; then
    _ms_list() {
        COMPREPLY=($(mpc lsplaylists))
    }
    complete -F _ms_list ms
fi

ms()
{
    if [ ! -z "$1" ]; then
        mpc -q clear
        mpc load $1
        mpc -q play
    else
        mpc lsplaylists
    fi
}
