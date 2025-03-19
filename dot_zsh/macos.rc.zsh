eval $(/opt/homebrew/bin/brew shellenv)

export HOMEBREW_PREFIX=$(brew --prefix)
export HOMEBREW_NO_ANALYTICS=1

if [[ -f "$HOME/.hombrew_github_api_token" ]]; then
  source "$HOME/.hombrew_github_api_token"
fi

if [[ -d "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" ]]; then
  path=($HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin(N-/) $path)
  alias ls="gls -AFh --color=auto"
  alias ll="gls -slAFh --color=auto"
  alias la="gls -aAFh --color=auto"
  alias lla="gls -slaAFh --color=auto"
fi

if [[ -d "$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin" ]]; then
  path=($HOMEBREW_PREFIX/opt/findutils/libexec/gnubin(N-/) $path)
fi

if [[ -d "$HOMEBREW_PREFIX/opt/gawk/libexec/gnubin" ]]; then
  path=($HOMEBREW_PREFIX/opt/gawk/libexec/gnubin(N-/) $path)
fi

if [[ -d "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin" ]]; then
  path=($HOMEBREW_PREFIX/opt/grep/libexec/gnubin(N-/) $path)
fi

if [[ -d "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" ]]; then
  path=($HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin(N-/) $path)
fi

if [[ -d "$HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin" ]]; then
  path=($HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin(N-/) $path)
fi

if [[ -x "$HOMEBREW_PREFIX/opt/gnu-which/libexec/gnubin" ]]; then
  path=($HOMEBREW_PREFIX/opt/gnu-which/libexec/gnubin(N-/) $path)
  alias which="which -a"
fi

if [[ -x "$HOMEBREW_PREFIX/opt/colordiff/bin" ]]; then
  alias diff=colordiff
fi

if [[ -x "$HOMEBREW_PREFIX/opt/openjdk/bin" ]]; then
  path=($HOMEBREW_PREFIX/opt/openjdk/bin(N-/) $path)
  # sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
  # export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
fi

