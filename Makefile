brew       := /usr/local/bin/brew
cider      := /usr/local/bin/cider
mackup     := /usr/local/bin/mackup
go         := /usr/local/go/bin/go
ghq        := $(HOME)/bin/ghq

dotfiles   := $(HOME)/src/github.com/YOwatari/dotfiles

bundle.tap := /usr/local/Library/Taps/homebrew/homebrew-bundle

zsh        := /usr/local/bin/zsh
zplug      := /usr/local/opt/zplug

cask.tap   := /usr/local/Library/Taps/caskroom/homebrew-cask
iterm2     := /Applications/iTerm.app

ricty.tap  := /usr/local/Library/Taps/sanemat/homebrew-font
ricty      := /usr/local/opt/ricty


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup:   ## initial deployment
setup: $(dotfiles)
	$(MAKE) -C $(dotfiles) install
	-/bin/rm -rf /tmp/dotfiles

install: ## install tools and applications
install: $(cider) $(mackup) $(ricty) $(iterm2) $(zsh) cider.relink deploy

deploy:  ## deploy tools and applications
deploy: cider.restore mackup.restore

dump:    ## dump installed tools and applications
	$(MAKE) brew.$@

.PHONY: help \
  setup install \
  deploy dump

brew.dump: $(brew)
	$< bundle --global --force dump

cider.clean:
	-/bin/rm -rf $(HOME)/.cider

cider.link: cider
	ln -sf $(CURDIR)/$< $(HOME)/.cider

cider.relink: cider.clean cider.link

cider.restore: $(cider) $(bundle.tap)
	/bin/rm -rf $(HOME)/.gitconfig
	/bin/rm -rf $(HOME)/.zshrc
	$< relink
	$< apply-defaults
	$< run-scripts

mackup.restore: $(mackup)
	$< restore

.PHONY: brew.dump \
  cider.clean cider.link cider.restore \
  mackup.restore

$(brew):
	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	$@ --version

python.tools := $(cider) $(mackup)
$(python.tools):
	sudo /usr/bin/easy_install install -U $(notdir $@)
	$@ --version

GO_VERSION=1.6.3
go$(GO_VERSION).darwin-amd64.pkg:
	curl -C - -O https://storage.googleapis.com/golang/$@

$(go): go$(GO_VERSION).darwin-amd64.pkg
	sudo installer -pkg $(CURDIR)/$< -target /
	$@ version

$(ghq): $(go)
	GOPATH=$(HOME) $< get github.com/motemen/ghq
	git config --global ghq.root "~/src"

$(bundle.tap): $(brew)
	$< tap Homebrew/bundle

$(zsh): $(brew)
	$< install zsh
	$(MAKE) $(zplug)

$(zplug): $(brew)
	-/bin/rm -rf $(HOME)/.zplug
	$< install zplug

$(cask.tap): $(brew)
	$< tap caskroom/cask

$(iterm2): $(cask.tap) $(ghq)
	$(brew) cask install --force iterm2
	$(ghq) get mbadolato/iTerm2-Color-Schemes

$(ricty.tap): $(brew)
	$< tap sanemat/font

$(ricty): $(ricty.tap)
	$(brew) install ricty --powerline --vim-powerline
	$(MAKE) $(shell find /usr/local/share/fonts/ -type f -name 'Ricty*.ttf' -exec basename {} \; | xargs -I{} echo "'$(HOME)/Library/Fonts/{}'")
	fc-cache -v

$(HOME)/Library/Fonts/Ricty%.ttf:
	cp -f /usr/local/share/fonts/$(notdir $@) $@

$(dotfiles): $(ghq)
	$(ghq) get https://github.com/YOwatari/dotfiles.git
	git --git-dir=$@/.git --work-tree=$@ submodule update --init --recursive

.PRECIOUS: $(brew) $(cider) $(mackup) $(go) $(ghq) \
  $(zsh) $(zplug) \
  $(bundle.tap) \
  $(cask.tap) $(iterm2) \
  $(ricty.tap) $(ricty) $(HOME)/Library/Fonts/Ricty%.ttf \
  $(dotfiles)
