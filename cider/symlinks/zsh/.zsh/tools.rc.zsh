# tmux
if [ -z "$TMUX" -a -z "$STY" ]; then
    if type tmuxx >/dev/null 2>&1; then
        tmuxx
    elif type tmux >/dev/null 2>&1; then
        if tmux has-session && tmux list-sessions | /usr/bin/grep -qE '.*]$'; then
            tmux attach && echo "tmux attached session "
        else
            tmux new-session && echo "tmux created new session"
        fi
    elif type screen >/dev/null 2>&1; then
        screen -rx || screen -D -RR
    fi
fi

# hub
# eval "$(hub alias -s)"

# anyenv
if [ -d ${HOME}/.anyenv ] ; then
    path=(~/.anyenv/bin(N-/) ${path})
    eval "$(anyenv init - --no-rehash)"
fi

export GOPATH=$HOME

# direnv
type direnv > /dev/null
if [ $? -eq 0 ]; then
    export EDITOR=vim
    eval "$(direnv hook zsh)"
fi

# gomi
if [ -x ${HOME}/bin/gomi ]; then
    alias rm="${HOME}/bin/gomi -s"
fi

# homebrew
export HOMEBREW_PREFIX=$(brew --prefix)
export HOMEBREW_NO_ANALYTICS=1

if [ -f ${HOME}/.github.token ]; then
    source ${HOME}/.github.token
fi

if [ -d ${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin ] ; then
    path=(${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin(N-/) ${path})
    alias ls="/usr/local/bin/gls -AFh --color=auto"
    alias ll="/usr/local/bin/gls -slAFh --color=auto"
    alias la="/usr/local/bin/gls -aAFh --color=auto"
    alias lla="/usr/local/bin/gls -slaAFh --color=auto"
fi

if [ -d ${HOMEBREW_PREFIX}/opt/colordiff/bin ] ; then
    alias diff="/usr/local/bin/colordiff"
    if [ -d ${HOMEBREW_PREFIX}/opt/less/bin ] ; then
        alias less="/usr/local/bin/less -R"
    fi
fi

if [ -d ${HOMEBREW_PREFIX}/opt/gnu-which/bin ] ; then
    alias which="/usr/local/bin/which -a"
fi

if [ -d ${HOMEBREW_PREFIX}/opt/groovy/libexec ]; then
    export GROOVY_HOME=${HOMEBREW_PREFIX}/opt/groovy/libexec
fi

if [ -d ${HOMEBREW_PREFIX}/opt/curl/bin ]; then
    if [ -d ${HOMEBREW_PREFIX}/etc/openssl ]; then
        alias mycurl="${HOMEBREW_PREFIX}/opt/curl/bin/curl --cacert ${HOMEBREW_PREFIX}/etc/openssl/cert.pem --capath ${HOMEBREW_PREFIX}/etc/openssl/certs"
    fi
fi

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
