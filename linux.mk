export SHELL := /bin/bash

DISTRO := $(shell lsb_release -si)
ARCH   := $(if $(filter $(shell uname -m), arm64 aarch64),arm64,amd64)

all: install

install: deps
	sudo apt-get install -y \
	  locales locales-all \
	  build-essential \
	  bash zsh \
	  tar gzip unzip xz-utils \
	  gpg gawk less rsync \
	  openssh-client \
	  openssl \
	  python python3 python3-pip python3-venv \
	  neovim python3-neovim \
	  default-libmysqlclient-dev default-mysql-client \
	  pass \
	  kubectl
	if [[ "$$(uname -r)" =~ microsoft ]]; then \
	  sudo apt-get install -y ubuntu-wsl keychain; \
	fi

deps:
ifneq ($(DISTRO),Ubuntu)
	$(error not support ditribution)
endif
ifeq ($(ARCH),arm64)
	$(error not support architecture)
endif
	sudo sed -i.bak -r 's!(deb|deb-src) \S+!\1 mirror+http://mirrors.ubuntu.com/mirrors.txt!' /etc/apt/sources.list
	sudo apt-get update
	sudo apt-get install -y apt-transport-https ca-certificates curl
	sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
	echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
