export N_PREFIX=$HOME/.n

path=($N_PREFIX/bin $path)

_zsh_n_install() {
  echo "Installing n..."
  curl -L https://git.io/n-install | bash -s -- -y
}


if ! command -v n &>/dev/null; then
  _zsh_n_install
fi
