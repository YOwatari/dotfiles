function snippets() {
    BUFFER=$(grep -v "^#" -h ~/.snippets* | \
        peco --prompt "Select snippets:" --query "${LBUFFER}")
    zle clear-screen
}
zle -N snippets
bindkey '^x^s' snippets

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
bindkey '^x^h' history_search

function snippets_register_history() {
    BUFFER=$(history_command)
    BUFFER=$(echo $BUFFER >> ~/.snippets)
    zle clear-screen
}
zle -N snippets_register_history
bindkey '^x^h^h' snippets_register_history

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
bindkey '^x^x' cd_ghq

function open_ghq() {
    local url=$(ghq list --full-path | \
        sed -e 's/\/Users\/y-ohwatari\/src\//https:\/\//g' | \
        sed -e 's/fluct\-gitlab\.dev\.fluct\.ec2:443/fluct-gitlab\.dev\.fluct\.ec2:8443/g' | \
        peco --prompt "open repository:" --query "${LBUFFER}")
    if [ -n $url ]; then
        BUFFER=$(open $url)
        zle accept-line
    fi
    zle clear-screen
}
zle -N open_ghq
bindkey '^x^z' open_ghq
