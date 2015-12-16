if 0 | endif

if filereadable(expand('~/.vim/load/neobundle.rc.vim'))
    runtime! load/neobundle.rc.vim
    if filereadable(expand('~/.vim/load/theme.rc.vim'))
        runtime! load/theme.rc.vim
    endif
    if filereadable(expand('~/.vim/load/plugins.rc.vim'))
        runtime! load/plugins.rc.vim
    endif
endif

if filereadable(expand('~/.vim/load/basic.rc.vim'))
    runtime! load/basic.rc.vim
endif
