if command -v nvim &>/dev/null; then
  alias vim=nvim
fi

if [[ -d $HOME/.asdf/installs/gcloud ]]; then
  source "$(find "$HOME/.asdf/installs/gcloud" -type f -name 'completion.zsh.inc')"
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
