all: setup apply-defaults bundle

setup:
	./zero/setup

bundle apply-defaults apply-symlinks:
	zero $@ --verbose
