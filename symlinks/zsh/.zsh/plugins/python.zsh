export PYENV_ROOT=$PYENV_HOME

path=(
  $HOME/Library/Python/2.7/bin
  $HOME/Library/Python/3.9/bin
  $path
)

_zsh_pipx_install() {
  echo "Installing pipx..."
  python3 -m pip install --user pipx
}

_zsh_pipx_load() {
  eval "$(register-python-argcomplete pipx)"
}

_zsh_poetry_install() {
  echo "Installing poetry..."
  if command -v brew &>/dev/null; then
    curl -sSL https://install.python-poetry.org | $(brew --prefix)/bin/python3 -
  else  
    curl -sSL https://install.python-poetry.org | python3 -
  fi
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
