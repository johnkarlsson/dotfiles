#!/bin/bash

# Moves old dotfiles to ~/.dotfiles_old and replaces them with symlinks to here.

dir=~/dotfiles
olddir=~/.dotfiles_old
files="xmonad vimrc vim" # zshrc oh-my-zsh"

mkdir -p $olddir

cd $dir

for file in $files; do
    mv ~/.$file ~/dotfiles_old/
    ln -s $dir/.$file ~/.$file
done
