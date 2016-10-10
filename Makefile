brew       := /usr/local/bin/brew

go         := /usr/local/go/bin/go
ghq        := $(HOME)/bin/ghq
gomi       := $(HOME)/bin/gomi

dotfiles   := $(HOME)/src/github.com/YOwatari/dotfiles

venv       := $(dotfiles)/.venv
virtualenv := /usr/local/bin/virtualenv
cider      := $(venv)/bin/cider
mackup     := $(venv)/bin/mackup

bundle.tap := /usr/local/Library/Taps/homebrew/homebrew-bundle

zsh        := /usr/local/bin/zsh

cask.tap   := /usr/local/Library/Taps/caskroom/homebrew-cask
iterm2     := /Applications/iTerm.app

ricty.tap  := /usr/local/Library/Taps/sanemat/homebrew-font
ricty      := /usr/local/opt/ricty

.PHONY: brew.dump \
  cider.clean cider.link cider.restore \
  mackup.restore \
  submodule.update

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup:   ## initial deployment
setup: go.tools $(dotfiles)
	$(MAKE) -C $(dotfiles) install
	-/bin/rm -rf /tmp/dotfiles

install: ## install tools and applications
install: $(venv) $(cider) $(mackup) $(ricty) $(iterm2) $(zsh) cider.relink deploy

deploy:  ## deploy tools and applications
deploy: cider.restore mackup.restore

dump:    ## dump installed tools and applications
dump: brew.dump submodule.update

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

submodule.update:
	git submodule update
	git submodule foreach git pull origin master

.INTERMEDIATE: go$(GO_VERSION).darwin-amd64.pkg

.PHONY: go.tools

$(brew):
	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	$@ --version

$(virtualenv):
	sudo easy_install virtualenv

$(venv): $(virtualenv)
	$< --no-site-packages $@

python.tools := $(cider) $(mackup)
$(python.tools): $(venv)
	$</bin/pip install -U $(notdir $@)
	$@ --version

GO_VERSION=1.7.1
go$(GO_VERSION).darwin-amd64.pkg:
	curl -C - -O https://storage.googleapis.com/golang/$@

$(go): go$(GO_VERSION).darwin-amd64.pkg
	sudo installer -pkg $(CURDIR)/$< -target /
	$@ version

$(ghq):
	GOPATH=$(HOME) $(go) get -u github.com/motemen/ghq/...
	git config --global ghq.root "~/src"

$(gomi):
	GOPATH=$(HOME) $(go) get -u github.com/b4b4r07/gomi/...

go.tools: $(go) $(ghq) $(gomi)

$(bundle.tap): $(brew)
	$< tap Homebrew/bundle

$(zsh): $(brew)
	$< install zsh

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

$(dotfiles): $(go) go.tools
	$(ghq) get https://github.com/YOwatari/dotfiles.git
	pushd $@
	git submodule update --init --recursive
	popd
