DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)

echo:
	@echo $(CANDIDATES)
	@echo $(DOTPATH)

list:
	@$(foreach val, $(CANDIDATES), /bin/ls -dF $(val);)

install:
	@$(foreach val, $(CANDIDATES),ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

.gitignore: gitignore/Global/macOS.gitignore gitignore/Global/Linux.gitignore gitignore/Global/Windows.gitignore gitignore/Global/Vim.gitignore gitignore/Global/JetBrains.gitignore gitignore/Global/VisualStudioCode.gitignore gitignore/Global/Xcode.gitignore
	@cat $^ > $@

