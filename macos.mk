all: setup apply-defaults bundle

setup:
	./zero/setup --verbose

bundle apply-defaults apply-symlinks:
	zero $@ --verbose
