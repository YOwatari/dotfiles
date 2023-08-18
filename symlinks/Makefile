all: ~/.asdfrc ~/.gitconfig ~/.gitignore ~/.vimrc ~/.vim ~/.config/nvim ~/.config/afx ~/.zsh ~/.zshrc

.gitignore: gitignore/Global/macOS.gitignore gitignore/Global/Linux.gitignore gitignore/Global/Windows.gitignore gitignore/Global/Vim.gitignore gitignore/Global/JetBrains.gitignore gitignore/Global/VisualStudioCode.gitignore gitignore/Global/Xcode.gitignore
	cat $^ > $@

~/.config:
	mkdir -p $@

~/.config/nvim: symlinks/nvim/.config/nvim ~/.config
	ln -sf $(abspath $<) $@

~/.config/afx: symlinks/afx ~/.config
	ln -sfnv $(abspath $<) $@

~/.zshrc: symlinks/zsh/.zshrc
	ln -sf $(abspath $<) $@

~/.zsh: symlinks/zsh/.zsh
	ln -sf $(abspath $<) $@
