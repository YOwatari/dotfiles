source ~/.zplug/zplug

zplug 'plugins/git', from:oh-my-zsh, if:'which git'
zplug 'plugins/brew', from:oh-my-zsh, if:'which brew'
zplug 'plugins/brew-cask', from:oh-my-zsh, if:'which brew'
zplug 'plugins/tmux', from:oh-my-zsh, if:'which tmux'
zplug 'plugins/vagrant', from:oh-my-zsh, if:'which vagrant'
zplug 'plugins/osx', from:oh-my-zsh, if:'[[ $ostype == *darwin* ]]'
zplug 'lib/clipboard', from:oh-my-zsh, if:'[[ $ostype == *darwin* ]]'
zplug 'jeremyFreeAgent/oh-my-zsh-powerline-theme', of:powerline.zsh-theme
zplug "zsh-users/zsh-syntax-highlighting", nice:10
zplug "zsh-users/zsh-completions"
zplug "mrowa44/emojify", as:command
zplug "b4b4r07/emoji-cli", if:"which jq"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
        echo; zplug install
    fi
fi

POWERLINE_HIDE_HOST_NAME='true'
POWERLINE_HIDE_GIT_PROMPT_STATUS='true'
POWERLINE_SHOW_GIT_ON_RIGHT='true'
POWERLINE_PATH='full'

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
source $HOME/.zsh/peco.rc.zsh
