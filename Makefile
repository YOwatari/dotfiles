OS          := $(shell uname | tr "[:upper:]" "[:lower:]")
OS_MAKEFILE := $(wildcard $(OS).mk)


.PHONY: all mise chezmoi docker dev help
.DEFAULT_GOAL := all

all: $(OS_MAKEFILE)
ifeq ($(OS_MAKEFILE),)
	@echo "No specific makefile found for OS $(OS). Skipping OS-specific setup."
	@exit 1
else
	$(MAKE) -f $(OS_MAKEFILE)
endif
	$(MAKE) chezmoi
	@echo "1. launch zsh"
	@echo "2. afx install"
	@echo "2. make mise"
	@echo "3. launch vim"

mise:
	$(MAKE) -f mise.mk

chezmoi:
	chezmoi update --recurse-submodules=false

dot_gitignore: external_gitignore/Global/macOS.gitignore external_gitignore/Global/Linux.gitignore external_gitignore/Global/Windows.gitignore external_gitignore/Global/Vim.gitignore external_gitignore/Global/VisualStudioCode.gitignore external_gitignore/Global/Xcode.gitignore
	@cat $^ > $@

#
# dev
#
docker:
	docker build \
	  --platform linux/amd64 \
	  --build-arg HOST_UID=$(shell id -u) \
	  --build-arg HOST_GID=$(shell id -g) \
	  -t dotfiles .

dev:
	docker run --rm -it \
	  --platform linux/amd64 \
	  -v $(HOME)/.ssh:/home/dot/.ssh \
	  -v $(CURDIR):/home/dot/.local/share/chezmoi \
	  --name dotfiles \
	  dotfiles

help:
	@echo "Available targets:"
	@echo "  all       : Run the default setup."
	@echo "  mise      : Run mise setup from mise.mk."
	@echo "  chezmoi   : Update chezmoi."
	@echo "  docker    : Build the development Docker image."
	@echo "  dev       : Run the development Docker container."
	@echo "  help      : Show this help message."
