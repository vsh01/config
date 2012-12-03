# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/usr/bin" ] ; then
    PATH="$HOME/usr/bin:$PATH"
fi

PATH="/sbin:/usr/sbin:$PATH"
export PAGER=most
export EDITOR=vim
export VIEWER=view


#export XDG_DATA_HOME="$HOME/.local/share"
#export XDG_CONFIG_HOME="$HOME/.config"
#update-desktop-database

#export TR_AUTH='transmission:transmission'
#export FLASH_FORCE_PULSEAUDIO=1
