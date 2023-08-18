export GOPATH=$HOME

path=($GOPATH/bin $path)

_zsh_gimme_install() {
  echo "Installing gimme..."
  mkdir -p "$GOPATH/bin"
  curl -sL -o "$GOPATH/bin/gimme" https://raw.githubusercontent.com/YOwatari/gimme/master/gimme
  chmod +x "$GOPATH/bin/gimme"
}

_zsh_gimme_load() {
  eval "$(gimme stable)"
}


if ! command -v gimme &>/dev/null; then
  _zsh_gimme_install
fi

if command -v gimme &>/dev/null; then
  _zsh_gimme_load
fi
