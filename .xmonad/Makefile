
targets := ~/.xinitrc ~/.local/bin/xmonad


all: $(targets)


~/.local/bin/xmonad: build ~/.local/bin/stack
	./build
	ln -sf $$(find ~/dotfiles/.xmonad/.stack-work/install -name xmonad-local-exe) ~/dotfiles/.xmonad/xmonad-x86_64-linux
	ln -sf ~/dotfiles/.xmonad/xmonad-x86_64-linux $@
	touch $$(find ~/dotfiles/.xmonad/.stack-work/install -name xmonad-local-exe)

~/.xinitrc:
	ln -sf ~/dotfiles/.xinitrc ~/.xinitrc

~/.local/bin/stack: /tmp/stack.tar.gz
	tar xf $^ -C $(dir $@) --strip-components=1 stack-1.7.1-linux-x86_64/stack
	touch $@

/tmp/stack.tar.gz:
	curl -Lso $@ https://get.haskellstack.org/stable/linux-x86_64.tar.gz

build:
	echo -e "#!/bin/sh\nstack build" > build
	chmod +x build
