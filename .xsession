xset s off
xset -dpms
xset s noblank
xset b off

setres.sh
sh ~/.fehbg &

#xmodmap ~/.xmodmaprc
#xmodmap ~/.xmodmaprc
setxkbmap -option caps:none

# autostart
/usr/bin/python2 /usr/bin/mopidy &
$HOME/libexec/jira_stop_on_lock.sh &

#exec ratpoison
exec awesome 
#exec $HOME/opt/awesome-3.5.8/bin/awesome

