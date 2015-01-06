#!/bin/bash

mkdir -p ~/dotfiles/src/vim
git clone https://github.com/b4winckler/vim ~/dotfiles/src/vim
sudo apt-get install libncurses5-dev python-dev
cd ~/dotfiles/src/vim
make distclean
./configure --with-features=huge --enable-pythoninterp
make
sudo ln -s ~/dotfiles/bin/vim /usr/local/bin/vim
