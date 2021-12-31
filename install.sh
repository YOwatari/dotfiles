#!/usr/bin/env bash

set -eu

SCRIPT_DIR="$(mktemp -d)"
trap 'rm -rf $SCRIPT_DIR' EXIT

download() {
  echo "downloading dotfiles..."

  if [ -x "$(which curl)" ] || [ -x "$(which wget)" ]; then
    tarball="https://github.com/YOwatari/dotfiles/archive/main.tar.gz"

    if [ -x "$(which curl)" ]; then
      curl -L "$tarball"
    elif [ -x "$(which wget)" ]; then
      wget -O - "$tarball"
    fi | tar x - -C "$SCRIPT_DIR"

  else
    echo "curl or wget is required"
    exit 2
  fi
}

init() {
    download
}

run() {
  if [ ! -x "$(which make)" ]; then
    echo "make is required"
    exit 2
  fi
  make -C "$SCRIPT_DIR/dotfiles-main" init
}

init
run

echo "done"
