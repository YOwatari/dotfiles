export PYENV_ROOT=$PYENV_HOME

path=($HOME/.local/bin(N-/) $path)

_zsh_pipx_install() {
  echo "Installing pipx..."
  python3 -m pip install --user pipx
}

_zsh_pipx_load() {
  eval "$(register-python-argcomplete pipx)"
}

_zsh_poetry_install() {
  echo "Installing poetry..."
  curl -sSL https://install.python-poetry.org | python3 -
  poetry completions zsh > "$HOME/.zsh/completions/_poetry"
}


if ! command -v pipx &>/dev/null; then
  _zsh_pipx_install
fi

if command -v pipx &>/dev/null; then
  _zsh_pipx_load
fi

if ! command -v poetry &>/dev/null; then
  _zsh_poetry_install
fi
