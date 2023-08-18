export PHPENV_ROOT=$HOME/.phpenv

path=($PHPENV_ROOT/bin $path)

_zsh_phpenv_install() {
  echo "Installing phpenv..."
  git clone https://github.com/phpenv/phpenv "$PHPENV_ROOT"
  git clone https://github.com/php-build/php-build "$PHPENV_ROOT/plugins/php-build"
  git clone https://github.com/madumlao/phpenv-aliases "$PHPENV_ROOT/plugins/phpenv-aliases"
  git clone https://github.com/ngyuki/phpenv-composer "$PHPENV_ROOT/plugins/phpenv-composer"
}

_zsh_phpenv_load() {
  eval "$(phpenv init -)"
}


if ! command -v phpenv &>/dev/null; then
  _zsh_phpenv_install
fi

if command -v phpenv &>/dev/null; then
  _zsh_phpenv_load
fi
