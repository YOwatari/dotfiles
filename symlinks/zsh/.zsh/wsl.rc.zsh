path=(
  /mnt/c/Program\ Files/Docker/Docker/resources/bin(N-/)
  /mnt/c/ProgramData/DockerDesktop/version-bin(N-/)
  $path
)

/usr/bin/keychain -q --nogui "$HOME/.ssh/id_rsa"
source $HOME/.keychain/$HOST-sh

DISP_IP=$(grep nameserver /etc/resolv.conf 2> /dev/null | /usr/bin/tr -s ' ' | /usr/bin/cut -d' ' -f2)
export DISPLAY=$DISP_IP:0.0
export NO_AT_BRIDGE=1

export BROWSER=wslview

alias open=wslview
alias pbcopy=/mnt/c/Windows/system32/clip.exe
