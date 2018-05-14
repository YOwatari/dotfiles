# zmodload zsh/zprof && zprof

if [[ $HOME/.zshrc -nt ~/.zshrc.zwc ]]; then
    zcompile ~/.zshrc
fi

if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

zstyle :zplug:tag depth 1

zplug 'git/git', as:command, use:contrib/diff-highlight/diff-highlight, hook-build:"make -C contrib/diff-highlight"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux, if:'which tmux'
zplug "LazoCoder/Pokemon-Terminal", as:command, use:pokemon

zplug 'yous/lime'
zplug 'zsh-users/zsh-completions'
zplug 'plugins/git', from:oh-my-zsh, if:'which git'
zplug 'plugins/tmux', from:oh-my-zsh, if:'which tmux'
zplug 'plugins/brew', from:oh-my-zsh, if:'which brew'
zplug 'plugins/brew-cask', from:oh-my-zsh, if:'which brew'

# zsh-syntax-highlighting.zsh wraps ZLE widgets. It must be sourced after all custom widgets have been created (i.e., after all zle -N calls and after running compinit).
zplug 'zsh-users/zsh-syntax-highlighting', defer:3

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
        echo; zplug install
    fi
fi

LIME_SHOW_HOSTNAME=1
LIME_DIR_DISPLAY_COMPONENTS=3
LIME_USER_COLOR=109
LIME_DIR_COLOR=143
LIME_GIT_COLOR=109

# Then, source plugins and add commands to $PATH
zplug load --verbose

export SHELL=$(which zsh)

typeset -U path cdpath fpath manpath
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))
path=(/usr/local{/bin,/sbin}(N-/) ${path})
path=(~/bin(N-/) /usr/local/go/bin(N-/) ${path})

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

source $HOME/.zsh/basic.rc.zsh
source $HOME/.zsh/tools.rc.zsh
source $HOME/.zsh/cmd.rc.zsh

# fzf
source $HOME/.zplug/repos/junegunn/fzf/shell/key-bindings.zsh
source $HOME/.zplug/repos/junegunn/fzf/shell/completion.zsh

# if (which zprof >/dev/null 2>&1); then
#     zprof
# fi

# pokemon
pokemon; clear

# credentials
source $HOME/.credentials.zsh
