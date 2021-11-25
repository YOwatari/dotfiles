DOTFILES := $(HOME)/.dotfiles

OS := $(shell uname | tr "[:upper:]" "[:lower:]")

.PHONY: all asdf symlinks docker dev init

all:
ifeq ($(OS),darwin)
	$(MAKE) -f macos.mk
endif
ifeq ($(OS),linux)
	$(MAKE) -f linux.mk
endif
	$(MAKE) symlinks
	@echo "1. launch zsh"
	@echo "2. make asdf"
	@echo "3. launch vim"

asdf symlinks:
	$(MAKE) -f $@.mk

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
