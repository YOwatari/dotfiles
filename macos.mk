all: setup bundle apply-defaults apply-symlinks

setup:
	sudo xcode-select --install
	./zero/setup

bundle apply-defaults apply-symlinks:
	zero $@
