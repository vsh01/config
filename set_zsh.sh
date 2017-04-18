#!/bin/bash
# install zsh and git
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

mkdir ~/.oh-my-zsh/custom/{plugins,themes} -p
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

cd "$(dirname "$(readlink -e "$0")")"

cp .zlogout .zprofile .zshrc ~/

