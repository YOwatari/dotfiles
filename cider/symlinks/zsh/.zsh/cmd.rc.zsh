function snippets() {
    BUFFER=$(grep -v "^#" -h ~/.snippets* | \
        peco --prompt "Select snippets:" --query "${LBUFFER}")
    zle clear-screen
}
zle -N snippets
bindkey '^S^S' snippets

function snippets_register_history() {
    BUFFER=$(history_command)
    BUFFER=$(echo $BUFFER >> ~/.snippets)
    zle clear-screen
}
zle -N snippets_register_history
bindkey '^H^H' snippets_register_history

function cd_ghq() {
    cd $(ghq root)/$(ghq list >/dev/null | fzf-tmux)
    zle reset-prompt
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
    else
        zle reset-prompt
    fi
}
zle -N open_repo
bindkey '^Z^Z' open_repo
