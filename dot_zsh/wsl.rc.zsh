path=(
  /mnt/c/Program\ Files/Docker/Docker/resources/bin(N-/)
  /mnt/c/ProgramData/DockerDesktop/version-bin(N-/)
  $path
)

keychain -q --nogui "$HOME/.ssh/id_rsa"
source $HOME/.keychain/$HOST-sh

export BROWSER=wslview

alias open=wslview
alias -g pbcopy='iconv -t sjis | /mnt/c/Windows/system32/clip.exe'

function add_op() {
  local win_op_path wsl_op_path
  win_op_path=$(powershell.exe -NoProfile -Command "Get-ChildItem -Path \$env:LOCALAPPDATA\\Microsoft\\WinGet\\Packages -Filter op.exe -Recurse | Select-Object -First 1 -ExpandProperty DirectoryName" | tr -d '\r\n')

  if [[ -n "$win_op_path" ]]; then
    wsl_op_path=$(wslpath "$win_op_path")
    mkdir -p "$HOME/.local/bin"
    ln -sf "$wsl_op_path/op.exe" "$HOME/.local/bin/op"
  fi
}
add_op
