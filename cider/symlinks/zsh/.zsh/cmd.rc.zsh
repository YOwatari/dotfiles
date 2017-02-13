function snippets() {
    BUFFER=$(grep -v "^#" -h ~/.snippets* | \
        peco --prompt "Select snippets:" --query "${LBUFFER}")
    zle clear-screen
}
zle -N snippets
bindkey '^S^S' snippets

function history_command() {
    history | sort -r | sed 1d | sed -e "s/^[ *0-9]*  \(.*\)/\1/g" | \
        peco --prompt "Select history:" --query "${LBUFFER}"
}
zle -N history_command

function history_search() {
    BUFFER=$(history_command)
    zle clear-screen
}
zle -N history_search
bindkey '^H^H' history_search

function snippets_register_history() {
    BUFFER=$(history_command)
    BUFFER=$(echo $BUFFER >> ~/.snippets)
    zle clear-screen
}
zle -N snippets_register_history
bindkey '^H^H^H' snippets_register_history

function cd_ghq() {
    local dir=$(ghq list --full-path | \
        peco --prompt "cd repository:" --query "${LBUFFER}")
    if [ -n $dir ]; then
        BUFFER="cd ${dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N cd_ghq
bindkey '^X^X' cd_ghq

function open_repo() {
    local url=$(pwd | \
        sed -e 's/\/Users\/y-ohwatari\/src\//https:\/\//g' | \
        sed -e 's/fluct\-gitlab\.dev\.fluct\.ec2:443/fluct-gitlab\.dev\.fluct\.ec2:8443/g')
    if [ -n $url ]; then
        BUFFER=$(open $url)
        zle accept-line
    fi
}
zle -N open_repo
bindkey '^Z^Z' open_repo

function tree_cd(){
    local goto=$(tree --charset=o -f | peco | tr -d '\||`|-' | xargs echo)
    if [ -n $goto ]; then
        BUFFER="cd ${goto}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N tree_cd
bindkey '^T^T' tree_cd

function tree_vim(){
  local file=$(tree --charset=o -f | peco | tr -d '\||`| ' | xargs echo)
  file=$file[3,-1]
  if [ -n $file ]; then
    BUFFER="vim ${file}"
    zle accept-line
  fi
  zle accept-line
}
zle -N tree_vim
bindkey "^V^V" tree_vim
