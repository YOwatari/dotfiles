function snippets() {
    BUFFER=$(grep -v "^#" -h ~/.snippets* | peco --prompt "Select snippets:" --query "$LBUFFER")
    zle clear-screen
}
zle -N snippets
bindkey '^x^s' snippets

function history_command() {
    history | sort -r | sed 1d | peco --prompt "Select history:" --query "$LBUFFER" | sed -e "s/^[ *0-9]*  \(.*\)/\1/g"
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
bindkey '^x^r' snippets_register_history

