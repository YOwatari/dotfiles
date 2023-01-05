let s:dein_base = expand('~/.config/dein')
let s:dein_src  = s:dein_base . '/repos/github.com/Shougo/dein.vim'

if &compatible
    set nocompatible
endif

" install
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_src)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_src
    endif
endif

execute 'set runtimepath+=' . s:dein_src


call dein#begin(s:dein_base)
let s:toml      = g:rc_dir . '/dein.toml'
let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
call dein#load_toml(s:toml,      {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})
call dein#end()

if has('filetype')
    filetype plugin indent on
endif

if has('syntax')
    syntax on
endif

" if dein#check_install()
"     call dein#install()
" endif

