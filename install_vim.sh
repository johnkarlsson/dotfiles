#!/bin/bash

mkdir -p ~/dotfiles/src/vim
git clone https://github.com/b4winckler/vim ~/dotfiles/src/vim
cd ~/dotfiles/src/vim
make distclean
./configure --with-features=huge
make
ln -s ~/dotfiles/bin/vim ~/bin/vim
