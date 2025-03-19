export RUSTUP_HOME=$HOME/.rustup
export CARGO_HOME=$HOME/.cargo

path=($CARGO_HOME/bin $path)

ZSH_COMPLETIONS="$HOME/.zsh/completions"

if command -v rustup &>/dev/null; then
  if [[ ! -f "$ZSH_COMPLETIONS/_rustup" ]]; then
    rustup completions zsh > "$ZSH_COMPLETIONS/_rustup"
  fi
  if [[ ! -f "$ZSH_COMPLETIONS/_cargo" ]]; then
    rustup completions zsh cargo > "$ZSH_COMPLETIONS/_cargo"
  fi
fi

