if command -v nvim &>/dev/null; then
  alias vim=nvim
fi

if command -v afx &>/dev/null; then
  source <(afx init)
  source <(afx completion zsh)
fi

if command -v mise &>/dev/null; then
    eval "$($HOME/bin/mise activate zsh)"
    eval "$($HOME/bin/mise activate --shims)"
fi

if [[ -f $HOME/.local/share/mise/installs/gcloud/latest/completion.zsh.inc ]]; then
  source "$HOME/.local/share/mise/installs/gcloud/latest/completion.zsh.inc"
fi

if command -v aws-vault &>/dev/null; then
  if command -v pass &>/dev/null; then
    export AWS_VAULT_BACKEND=pass
    export AWS_VAULT_PASS_PREFIX=aws-vault
  fi
  eval "$(aws-vault --completion-script-zsh)"
fi

if command -v pack &>/dev/null; then
  source "$(pack completion --shell zsh)"
fi

if [[ -d $HOME/.deno ]]; then
  export DENO_INSTALL="$HOME/.deno"
  path=(~/.deno/bin(N-/) $path)
fi

if [[ -d $HOME/.rye ]]; then
  path=(~/.rye/shims(N-/) $path)
fi

if [[ -f $HOME/.wasmedge/env ]]; then
  source "$HOME/.wasmedge/env"
fi
