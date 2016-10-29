ssh()
{
    if [[ "$TERM" == "rxvt-unicode-256color" ]]; then
        /usr/bin/env TERM="rxvt-unicode" /usr/bin/ssh $@
    else
        /usr/bin/ssh $@
    fi
}

