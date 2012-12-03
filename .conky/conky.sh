#!/bin/sh
killall conky
conky -d -c ~/.conky/main_conkyrc
conky -d -c ~/.conky/mpd_conkyrc
conky -d -c ~/.conky/processess_conkyrc

