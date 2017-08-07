FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    curl \
    software-properties-common \
    git \
    htop
RUN git clone https://github.com/johnkarlsson/dotfiles ~/dotfiles

# Neovim
RUN add-apt-repository ppa:neovim-ppa/stable
RUN apt-get update && apt-get install -y \
    python-dev \
    python-pip \
    python3-dev \
    python3-pip \
    neovim
ENV LC_ALL=C
RUN pip install --upgrade pip
RUN pip install neovim autopep8
RUN pip3 install --upgrade pip
RUN pip3 install neovim
RUN mkdir -p ~/.config/nvim
RUN ln -s ~/dotfiles/.vimrc ~/.config/nvim/init.vim
RUN ln -s ~/dotfiles/.vim/colors ~/.config/nvim/colors
# Plugins
RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim -c "PlugInstall" -c "qa!" --headless

# Haskell
RUN curl -sSL https://get.haskellstack.org/ | sh
RUN stack setup --install-ghc
RUN stack install hdevtools ghc-mod
RUN echo 'PATH=$PATH:~/.local/bin' >> ~/.zshenv

# zsh
RUN apt-get update && apt-get install -y zsh
ENV TERM xterm
RUN chsh -s $(which zsh)
RUN ln -s ~/dotfiles/.zshrc ~/.zshrc
RUN mkdir -p /home/john/Projects
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting /home/john/Projects/zsh-syntax-highlighting
RUN touch ~/.zshrc_extras
RUN git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# tmux
RUN apt-get update && apt-get install -y tmux
RUN ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
RUN ln -s ~/dotfiles/.tmux.reset.conf ~/.tmux.reset.conf

# Locales
RUN apt-get update && apt-get install -y \
        locales
RUN dpkg-reconfigure locales && \
    locale-gen sv_SE.UTF-8 && \
    update-locale LANG=sv_SE.UTF-8
ENV LANG sv_SE.UTF-8
