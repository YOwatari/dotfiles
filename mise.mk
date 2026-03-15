OS := $(shell uname | tr "[:upper:]" "[:lower:]")
MISE_BIN := $(HOME)/.local/bin/mise

all: bootstrap install aws-session-manager-plugin

bootstrap:
	@if [ ! -x "$(MISE_BIN)" ]; then \
		echo "Installing mise..."; \
		curl https://mise.run | sh; \
	else \
		echo "mise already installed, running self-update..."; \
		$(MISE_BIN) self-update; \
	fi

install:
	$(MISE_BIN) install

ifeq ($(OS),darwin)
aws-session-manager-plugin: vendor/session-manager-plugin.pkg
	sudo installer -pkg $< -target /Volumes/Macintosh\ HD
	sudo ln -s /usr/local/sessionmanagerplugin/bin/session-manager-plugin /usr/local/bin/session-manager-plugin
endif
ifeq ($(OS),linux)
aws-session-manager-plugin: vendor/session-manager-plugin.deb
	sudo dpkg -i $<
endif

vendor/session-manager-plugin.deb:
	curl -sSL -o $@ "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb"

vendor/session-manager-plugin.pkg:
	curl -sSL -o $@ "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/mac/session-manager-plugin.pkg"
