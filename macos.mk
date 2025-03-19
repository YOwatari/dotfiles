all: setup apply-defaults bundle

apply-symlinks:
	zero $@ --verbose

bundle:
	brew bundle

apply-defaults:
	./.macos
