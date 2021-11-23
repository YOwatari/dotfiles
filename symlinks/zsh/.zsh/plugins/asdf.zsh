export ASDF_DIR=$HOME/.asdf

path=($ASDF_DIR/bin $path)

_zsh_asdf_install() {
  echo "Installing asdf..."
  git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch v0.8.1
}

_zsh_asdf_load() {
  . "$HOME/.asdf/asdf.sh"
  fpath=($ASDF_DIR/completions(N-/) $fpath)
}


if ! command -v asdf &>/dev/null; then
  _zsh_asdf_install
fi

if command -v asdf &>/dev/null; then
  _zsh_asdf_load
fi
