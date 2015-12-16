let s:plugins_dir = '~/.vim/bundle/'

if has('vim_starting')
    if &compatible
        set nocompatible
    endif

    if !isdirectory(expand(s:plugins_dir . '/neobundle.vim'))
        execute '!git clone git@github.com:Shougo/neobundle.vim.git ' . s:plugins_dir . '/neobundle.vim'
        finish
    endif

    execute 'set runtimepath+=' . s:plugins_dir . '/neobundle.vim'
endif

call neobundle#begin(expand(s:plugins_dir))

if neobundle#load_cache()
    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/vimproc.vim', {
                \ 'build': {
                    \ 'mac': 'make -f make_mac.mak',
                    \ 'unix': 'make -f make_unix.mak',
                    \ 'cygwin': 'make -f make_cygwin.mak',
                    \ 'windows': 'tools\\update-dll-mingw',
                    \ }
                \ }

    call neobundle#load_toml('~/.vim/neobundle.toml')
    call neobundle#load_toml('~/.vim/neobundlelazy.toml', {'lazy': 1})

    NeoBundleSaveCache
endif

filetype plugin indent on
NeoBundleCheck

call neobundle#end()
