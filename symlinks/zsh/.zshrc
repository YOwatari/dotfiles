if [[ $HOME/.zshrc -nt ~/.zshrc.zwc ]]; then
    zcompile ~/.zshrc
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export ZPLUG_HOME=$HOME/.zplug
if [[ ! -d $ZPLUG_HOME ]]; then
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
source "$ZPLUG_HOME/init.zsh"

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "yous/lime"

zplug "zsh-users/zsh-completions"
zplug "junegunn/fzf", use:"shell/*.zsh"
zplug "jonmosco/kube-ps1", use:"kube-ps1.sh"
zplug "plugins/git", from:oh-my-zsh
zplug "pyenv/pyenv", use:"completions/*.zsh"
zplug "phpenv/phpenv", use:"completions/*.zsh"

zplug "tj/git-extras", as:command, use:"bin/git-{delete-submodule,delete-squashed-branches,delete-merged-branches,show-merged-branches,show-unmerged-branches}"
zplug "paulirish/git-open", as:command, use:git-open
zplug "tsenart/vegeta", as:command, from:gh-r, rename-to:vegeta

zplug "mattberther/zsh-pyenv"
zplug "~/.zsh/plugins", from:local

zplug "zsh-users/zsh-syntax-highlighting", defer:3

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load --verbose

if zplug check 'yous/lime'; then
    # https://github.com/yous/lime#options
    LIME_SHOW_HOSTNAME=1
    LIME_DIR_DISPLAY_COMPONENTS=3
    LIME_USER_COLOR=109
    LIME_DIR_COLOR=143
    LIME_GIT_COLOR=109
fi

PROMPT='$(kube_ps1)'' '$PROMPT'
\$ '

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

typeset -U path cdpath fpath manpath
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))
path=(/usr/local{/bin,/sbin}(N-/) $path)
fpath=(~/.zsh/completions(N-/) $fpath)

export GPG_TTY=$(tty)
export EDITOR=vim

source $HOME/.zsh/base.rc.zsh
source $HOME/.zsh/cmd.rc.zsh
source $HOME/.zsh/tool.rc.zsh

if [[ "$(uname -r)" =~ "microsoft" ]]; then
    source $HOME/.zsh/wsl.rc.zsh
fi

if [[ "$(uname)" = "Darwin" ]]; then
    source $HOME/.zsh/macos.rs.zsh
fi
