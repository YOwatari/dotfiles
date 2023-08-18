path=($HOME/.local/bin $path)

_zsh_direnv_install() {
  echo "Installing direnv..."
  curl -sfL https://direnv.net/install.sh | bin_path=$HOME/.local/bin bash
}

_zsh_direnv_load() {
  eval "$(direnv hook zsh)"
}


if ! command -v direnv &>/dev/null; then
  _zsh_direnv_install
fi

if command -v direnv &>/dev/null; then
  _zsh_direnv_load
fi
