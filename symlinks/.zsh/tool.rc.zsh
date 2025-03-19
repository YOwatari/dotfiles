if command -v nvim &>/dev/null; then
  alias vim=nvim
fi

if command -v afx &>/dev/null; then
  source <(afx init)
  source <(afx completion zsh)
fi

if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
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

if command -v fzf &>/dev/null; then
  export FZF_DEFAULT_COMMAND="fd --type f"
  export FZF_DEFAULT_OPTS="--height 50% --reverse"
  export FZF_CTRL_T_COMMAND="rg --files --hidden --follow --glob '!.git/*'"
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=header,grid --line-range :100 {}'"
  export FZF_ALT_C_COMMAND="fd --type d"
fi

if command -v fzf &>/dev/null; then
  export FZF_DEFAULT_COMMAND="fd --type f"
  export FZF_DEFAULT_OPTS="--height 50% --reverse"
  export FZF_CTRL_T_COMMAND="rg --files --hidden --follow --glob '!.git/*'"
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=header,grid --line-range :100 {}'"
  export FZF_ALT_C_COMMAND="fd --type d"
fi

if [[ -d $HOME/.codeium/windsurf/bin ]]; then
  path=(~/.codeium/windsurf/bin(N-/) $path)
fi
