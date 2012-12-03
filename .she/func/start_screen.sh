alias s='startscreen'

startscreen() 
{
    if [ "$1" = "l" ]; then
        screen -ls
        return 
    fi
    if [ -z "$STY" ]; then
        if [ -z "$1" ]; then
            exec screen -dR "t$$"
        else 
            exec screen -dR "$1"
        fi
    fi
}
