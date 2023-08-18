export RUSTUP_HOME=$HOME/.rustup
export CARGO_HOME=$HOME/.cargo

path=($CARGO_HOME/bin $path)

_zsh_rustup_install() {
  echo "Installing rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
  rustup completions zsh > "$HOME/.zsh/completions/_rustup"
  rustup completions zsh cargo > "$HOME/.zsh/completions/_cargo"
}


if ! command -v rustup &>/dev/null; then
  _zsh_rustup_install
fi
