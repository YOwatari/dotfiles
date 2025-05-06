all: bundle apply-defaults

bundle:
	brew bundle

apply-defaults:
	./.macos
