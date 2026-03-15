eval $(/opt/homebrew/bin/brew shellenv)

export HOMEBREW_NO_ANALYTICS=1

# GNU tools PATH (for script compatibility)
local -a gnu_tools=(coreutils findutils gawk grep gnu-sed gnu-tar gnu-which)
for tool in $gnu_tools; do
  local gnubin="$HOMEBREW_PREFIX/opt/$tool/libexec/gnubin"
  if [[ -d "$gnubin" ]]; then
    path=($gnubin(N-/) $path)
  fi
done

# Java
if [[ -d "$HOMEBREW_PREFIX/opt/openjdk/bin" ]]; then
  path=($HOMEBREW_PREFIX/opt/openjdk/bin(N-/) $path)
fi
