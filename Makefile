DOTFILES := $(HOME)/.dotfiles

OS := $(shell uname | tr "[:upper:]" "[:lower:]")

all:
ifeq ($(OS),darwin)
	$(MAKE) -f macos.mk
endif
ifeq ($(OS),linux)
	$(MAKE) -f linux.mk
endif
	@echo "1. launch zsh"
	@echo "2. make asdf"
	@echo "3. launch vim"

asdf:
	$(MAKE) -f asdf.mk all

symlinks/git/.gitignore: gitignore/Global/macOS.gitignore gitignore/Global/Linux.gitignore gitignore/Global/Windows.gitignore gitignore/Global/Vim.gitignore gitignore/Global/JetBrains.gitignore gitignore/Global/VisualStudioCode.gitignore gitignore/Global/Xcode.gitignore
	cat $^ > $@

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
