all: ~/.asdfrc ~/.gitconfig ~/.gitignore ~/.vimrc ~/.vim ~/.config/nvim ~/.zsh ~/.zshrc

~/.asdfrc: symlinks/asdf/.asdfrc
	ln -sf $(abspath $<) $@

~/.gitconfig: symlinks/git/.gitconfig
	ln -sf $(abspath $<) $@

symlinks/git/.gitignore: gitignore/Global/macOS.gitignore gitignore/Global/Linux.gitignore gitignore/Global/Windows.gitignore gitignore/Global/Vim.gitignore gitignore/Global/JetBrains.gitignore gitignore/Global/VisualStudioCode.gitignore gitignore/Global/Xcode.gitignore
	cat $^ > $@

~/.gitignore: symlinks/git/.gitignore
	ln -sf $(abspath $<) $@

~/.vimrc: symlinks/nvim/.vimrc
	ln -sf $(abspath $<) $@

~/.vim: symlinks/nvim/.vim
	ln -sf $(abspath $<) $@

~/.config:
	mkdir -p $@

~/.config/nvim: symlinks/nvim/.config/nvim ~/.config
	ln -sf $(abspath $<) $@

~/.config/afx: symlinks/afx ~/.config
	ln -sf $(abspath $<) $@

~/.zshrc: symlinks/zsh/.zshrc
	ln -sf $(abspath $<) $@

~/.zsh: symlinks/zsh/.zsh
	ln -sf $(abspath $<) $@
