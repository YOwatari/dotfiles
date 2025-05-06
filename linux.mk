export SHELL := /bin/bash

DISTRO := $(shell lsb_release -si)
ARCH   := $(if $(filter $(shell uname -m), arm64 aarch64),arm64,amd64)

all: install

install: deps neovim afx
	sudo apt-get install -y \
	  locales locales-all \
	  build-essential \
	  bash zsh \
	  tar gzip unzip xz-utils \
	  gpg gawk less rsync \
	  openssh-client \
	  openssl \
	  python python3 python3-pip python3-venv \
	  default-libmysqlclient-dev default-mysql-client \
	  pass \
	  git-extras
	if [[ "$$(uname -r)" =~ microsoft ]]; then \
	  sudo apt-get install -y ubuntu-wsl keychain; \
	fi

neovim:
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod +x nvim.appimage
	sudo mv nvim.appimage /usr/local/bin/nvim

afx:
	curl -sL https://raw.githubusercontent.com/b4b4r07/afx/HEAD/hack/install | bash

deps:
ifneq ($(DISTRO),Ubuntu)
	$(error not support ditribution)
endif
ifeq ($(ARCH),arm64)
	$(error not support architecture)
endif
	sudo sed -i.bak -r 's!(deb|deb-src) \S+!\1 mirror+http://mirrors.ubuntu.com/mirrors.txt!' /etc/apt/sources.list
	sudo apt-get update
