#!/bin/sh

DOTPATH=/tmp/dotfiles
HOSTNAME=YOwatari-Mac

download() {
	echo "dotfiles intializing..."
	rm -rf "$DOTPATH"

	if [ `which curl` ] || [ `which wget` ]; then
		tarball="https://github.com/YOwatari/dotfiles/archive/master.tar.gz"

		if [ `which curl` ]; then
			curl -L "$tarball"
		elif [ `which wget` ]; then
			wget -O - "$tarball"
		fi | tar xv -

		mv -f dotfiles-master "$DOTPATH"
	else
		echo "curl or wget required"
		exit 1
	fi

	cd $DOTPATH
	if [ $? -ne 0 ]; then
		echo "not found: $DOTPATH"
		exit 1
	fi
}

initialize() {
    download
    sudo scutil --set ComputerName "$HOSTNAME"
    sudo scutil --set LocalHostName "$HOSTNAME"
}

install() {
	make -C "$DOTPATH" init
}

initialize
install
