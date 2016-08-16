## 補完
autoload -U compinit
compinit
setopt list_types
setopt auto_resume
setopt auto_list
setopt auto_menu
setopt auto_cd
setopt auto_param_keys
setopt auto_param_slash
setopt magic_equal_subst
setopt equals
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## ヒストリ
setopt hist_ignore_dups
setopt extended_history
setopt hist_verify
setopt share_history

## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob

## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort

## スペルチェック
setopt correct

## コアダンプサイズを制限
limit coredumpsize 102400

## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr

## 色を使う
setopt prompt_subst

## ビープを鳴らさない
setopt nobeep

## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

## cd 時に自動で push
setopt autopushd

## 同じディレクトリを pushd しない
setopt pushd_ignore_dups

## 出力時8ビットを通す
setopt print_eight_bit


## alias
alias sub='/usr/bin/open -a ~/Applications/Sublime\ Text\ 2.app'
alias gping='/sbin/ping -c 5 8.8.8.8'

## set editor bind
bindkey -e
