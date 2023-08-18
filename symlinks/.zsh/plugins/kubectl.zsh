export KREW_ROOT=$HOME/.krew

path=($KREW_ROOT/bin(N-/) $path)

_zsh_kubectl_load() {
  source <(kubectl completion zsh)
  alias k=kubectl
  compdef __start_kubectl k
}

_zsh_krew_install() {
  echo "Installing krew..."
  (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
  )
}

_zsh_krew_plugins() {
  if ! command -v "kubectl-$1" &>/dev/null; then
    kubectl krew install "$1"
  fi
}


if command -v kubectl &>/dev/null; then
  _zsh_kubectl_load

  if ! command -v kubectl-krew &>/dev/null; then
    _zsh_krew_install
  fi

  _zsh_krew_plugins "ctx"
  _zsh_krew_plugins "ns"
  #_zsh_krew_plugins "tail"
fi
