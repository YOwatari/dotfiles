all: setup apply-defaults bundle

setup:
	sudo xcode-select --install
	./zero/setup

bundle apply-defaults apply-symlinks:
	zero $@ --verbose
