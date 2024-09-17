OS := $(shell uname | tr "[:upper:]" "[:lower:]")

PACKAGES := awscli aws-sam-cli aws-vault gcloud bat buildpack bun delta deno duf editorconfig-checker fd fzf ghq github-cli go gomigrate jq jsonnet mkcert node protoc racket ripgrep rust rye sqlite terraform yq

# bat delta protoc by brew for Apple Silicon
all: $(PACKAGES) aws-session-manager-plugin

$(PACKAGES):
	mise use --global -y $@@latest

ruby:
	mise use --global -y $@@2.3.8

php:
	mise install $@@8.0
	mise install $@@8.1
	mise install $@@8.2
	mise use --global -y $@@8.1

node:
	mise use --global -y $@@lts


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

