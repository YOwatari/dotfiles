if command -v nvim &>/dev/null; then
  alias vim=nvim
fi

fpath=(/usr/share/google-cloud-sdk/completion.zsh.inc $fpath)
fpath=(/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc $fpath)

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
