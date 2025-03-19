DOTFILES := $(HOME)/.dotfiles

OS := $(shell uname | tr "[:upper:]" "[:lower:]")

.PHONY: all mise chezmoi docker dev init

all:
ifeq ($(OS),darwin)
	$(MAKE) -f macos.mk
endif
ifeq ($(OS),linux)
	$(MAKE) -f linux.mk
endif
	@echo "1. launch zsh"
	@echo "2. make mise"
	@echo "3. make chezmoi"
	@echo "4. launch vim"

mise:
	$(MAKE) -f $@.mk

chezmoi:
	chezmoi update

dot_gitignore: gitignore/Global/macOS.gitignore gitignore/Global/Linux.gitignore gitignore/Global/Windows.gitignore gitignore/Global/Vim.gitignore gitignore/Global/VisualStudioCode.gitignore gitignore/Global/Xcode.gitignore
	@cat $^ > $@

#
# dev
#
docker:
	docker build -t dotfiles .

dev:
	docker run --rm -it -v $(CURDIR):/home/dot/.dotfiles --name dotfiles dotfiles

#
# init
#
init: $(DOTFILES)
	$(MAKE) -C $(DOTFILES)

$(DOTFILES):
	git clone --recursive https://github.com/YOwatari/dotfiles.git $@

