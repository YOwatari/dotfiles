function cd_ghq() {
    local dir=$(ghq list | fzf)
    if [ ! -z $dir ]; then
        cd "$(ghq root)/$dir"
    fi
    zle reset-prompt
}
zle -N cd_ghq
bindkey '^X^X' cd_ghq

function fbr() {
 local branches branch
 branches=$(git branch --all | grep -v HEAD) &&
 branch=$(echo "$branches" |
          fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
 git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

