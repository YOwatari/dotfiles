OS := $(shell uname | tr "[:upper:]" "[:lower:]")

all: awscli aws-vault gcloud bat buildpack delta duf fzf ghq jq jsonnet mkcert protoc ripgrep sops terraform yq
all: aws-session-manager-plugin

awscli aws-vault gcloud bat buildpack delta duf fzf ghq jq jsonnet mkcert protoc ripgrep sops terraform yq:
	asdf plugin add $@
	asdf install $@ latest
	asdf global $@ latest

ifeq ($(OS),darwin)
aws-session-manager-plugin: vendor/session-manager-plugin.pkg
	sudo installer -pkg $< -target /Volumes/Macintosh\ HD
	ln -s /usr/local/sessionmanagerplugin/bin/session-manager-plugin /usr/local/bin/session-manager-plugin
endif
ifeq ($(OS),linux)
aws-session-manager-plugin: vendor/session-manager-plugin.deb
	sudo dpkg -i $<
endif

vendor/session-manager-plugin.deb:
	curl -sSL -o $@ "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb"

vendor/session-manager-plugin.pkg:
	curl -sSL -o $@ "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/mac/session-manager-plugin.pkg"
