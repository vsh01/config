#!/bin/bash
cp -R .screenrc .she .vim .vimrc .z* ~/
dircolors -p > ~/.dircolors
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

