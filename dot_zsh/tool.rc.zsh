# Modern tool aliases
if command -v nvim &>/dev/null; then
  alias vim=nvim
fi

if command -v eza &>/dev/null; then
  alias ls="eza -aF"
  alias ll="eza -laF"
  alias la="eza -aF"
  alias lla="eza -laF"
fi

if command -v bat &>/dev/null; then
  alias cat="bat --paging=never"
fi

if command -v delta &>/dev/null; then
  alias diff=delta
fi

if command -v duf &>/dev/null; then
  alias du=duf
fi

if command -v sheldon &>/dev/null; then
  eval "$(sheldon source)"
fi

# fzf
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="--height 50% --reverse"
export FZF_CTRL_T_COMMAND="rg --files --hidden --follow --glob '!.git/*'"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=header,grid --line-range :100 {}'"
export FZF_ALT_C_COMMAND="fd --type d"

# lime prompt
export LIME_SHOW_HOSTNAME=1
export LIME_DIR_DISPLAY_COMPONENTS=3
export LIME_USER_COLOR=109
export LIME_DIR_COLOR=143
export LIME_GIT_COLOR=109

if command -v mise &>/dev/null; then
    eval "$($HOME/.local/bin/mise activate zsh)"
    eval "$($HOME/.local/bin/mise activate --shims)"
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

# homebrew packages
if command -v brew &>/dev/null; then
  local brew_prefix="$(brew --prefix)"
  if [[ -d "$brew_prefix/opt/mysql-client/bin" ]]; then
    export PATH="$brew_prefix/opt/mysql-client/bin:$PATH"
  fi
fi
