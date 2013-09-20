dotfiles
========

To get started:
```
    cd ~
    git clone git@github.com:johnkarlsson/dotfiles.git
    git submodule init
    git submodule update
    ./dotfiles/install.sh
    ./dotfiles/gitconfigs.sh
```

To add submodule (example):
```
    cd ~/dotfiles/
    git submodule add https://github.com/tpope/vim-fugitive .vim/bundle/vim-fugitive
```

To upgrade all submodules:
```
    git submodule foreach git pull origin master
```
