.PHONY: init install deploy \
        homebrew/install \
        cider/install cider/link cider/restore \
        mackup/install mackup/link mackup/restore \
        golang/install ghq/install \
        ricty/install iterm2/install zsh/install \
        init/cleanup

init: homebrew/install cider/install mackup/install golang/install ghq/install init/cleanup

install: cider/link

deploy: cider/restore mackup/restore

homebrew/install:
	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

cider/install:
	sudo easy_install -U cider

cider/link:
	-rm -rf $(HOME)/.cider
	ln -sf $(CURDIR)/.cider $(HOME)/.cider

cider/restore:
	rm -rf $(HOME)/.gitconfig
	rm -rf $(HOME)/.zshrc
	cider relink
	brew tap Homebrew/bundle
	cider apply-defaults
	cider run-scripts

mackup/install:
	sudo easy_install -U mackup

mackup/restore:
	mackup restore

golang/install: VERSION=1.5.2
golang/install: PKG=go$(VERSION).darwin-amd64.pkg
golang/install:
	-rm -f $(CURDIR)/$(PKG)
	curl -C - -O https://storage.googleapis.com/golang/$(PKG)
	sudo installer -pkg $(CURDIR)/$(PKG) -target /

ghq/install:
	GOPATH=$(HOME) /usr/local/go/bin/go get github.com/motemen/ghq
	git config --global ghq.root "~/src"

zsh/install:
	brew install zsh
	-rm -rf $(HOME)/.zplug
	curl -fLo $(HOME)/.zplug/zplug --create-dirs https://git.io/zplug

iterm2/install:
	brew tap caskroom/cask
	brew cask instal iterm2
	$(HOME)/bin/ghq get mbadolato/iTerm2-Color-Schemes

ricty/install:
	brew tap sanemat/font
	brew install ricty --powerline --vim-powerline
	cp -f /usr/local/share/fonts/Ricty*.ttf ~/Library/Fonts/
	fc-cache -v

init/cleanup:
	$(HOME)/bin/ghq get https://github.com/YOwatari/dotfiles.git
	cd $(HOME)/src/github.com/YOwatari/dotfiles && git submodule update --init --recursive
	$(MAKE) -C $(HOME)/src/github.com/YOwatari/dotfiles install cider/restore ricty/install iterm2/install zsh/install
	$(MAKE) -C $(HOME)/src/github.com/YOwatari/dotfiles mackup/restore
	-rm -rf /tmp/dotfiles
