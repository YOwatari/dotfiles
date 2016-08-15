export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug 'mrowa44/emojify', as:command
zplug 'b4b4r07/emoji-cli', if:'which jq'
zplug 'git/git', as:command, use:'contrib/diff-highlight/diff-highlight'

zplug 'plugins/git', from:oh-my-zsh, if:'which git', nice:10
zplug 'plugins/brew', from:oh-my-zsh, if:'which brew', nice:10
zplug 'plugins/brew-cask', from:oh-my-zsh, if:'which brew', nice:10
zplug 'plugins/tmux', from:oh-my-zsh, if:'which tmux', nice:10
zplug 'plugins/vagrant', from:oh-my-zsh, if:'which vagrant', nice:10
zplug 'plugins/osx', from:oh-my-zsh, if:'[[ $OSTYPE == *darwin* ]]', nice:10
zplug 'lib/clipboard', from:oh-my-zsh, if:'[[ $OSTYPE == *darwin* ]]', nice:10

zplug 'jeremyFreeAgent/oh-my-zsh-powerline-theme', use:'powerline.zsh-theme', nice:15
zplug 'zsh-users/zsh-syntax-highlighting', nice:15
zplug 'zsh-users/zsh-completions', nice:15

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

# added by travis gem
[ -f /Users/y-ohwatari/.travis/travis.sh ] && source /Users/y-ohwatari/.travis/travis.sh
