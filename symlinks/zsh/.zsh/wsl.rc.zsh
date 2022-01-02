path=(
  /mnt/c/Program\ Files/Docker/Docker/resources/bin(N-/)
  /mnt/c/ProgramData/DockerDesktop/version-bin(N-/)
  $path
)

keychain -q --nogui "$HOME/.ssh/id_rsa"
source $HOME/.keychain/$HOST-sh

export BROWSER=wslview

alias open=wslview
alias pbcopy=/mnt/c/Windows/system32/clip.exe

