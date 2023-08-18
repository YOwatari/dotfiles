if [[ $HOME/.zshrc -nt ~/.zshrc.zwc ]]; then
    zcompile ~/.zshrc
fi

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

typeset -U path cdpath fpath manpath
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))
path=(/usr/local{/bin,/sbin}(N-/) $path)
path=(~/bin(N-/) $path)
fpath=(~/.zsh/completions(N-/) $fpath)

export TERM=xterm-256color
export GPG_TTY=$(tty)
export EDITOR=vim

source $HOME/.zsh/base.rc.zsh
source $HOME/.zsh/cmd.rc.zsh
source $HOME/.zsh/tool.rc.zsh

if [[ "$(uname -r)" =~ "microsoft" ]]; then
    source $HOME/.zsh/wsl.rc.zsh
fi

if [[ "$(uname)" = "Darwin" ]]; then
    source $HOME/.zsh/macos.rc.zsh
fi

#PROMPT='$(kube_ps1)'' '$PROMPT'
PROMPT=$PROMPT'
\$ '

