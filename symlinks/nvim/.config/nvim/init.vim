if has('nvim')
    let g:vim_home = expand('~/.config/nvim')
    let g:rc_dir = expand('~/.config/nvim/rc')
else
    let g:vim_home = expand('~/.vim')
    let g:rc_dir = expand('~/.vim/rc')
endif


function! s:load(file) abort
    let path = expand(g:rc_dir . '/' . a:file)
    if filereadable(path)
        execute 'source' fnameescape(path)
    endif
endfunction


"---------------------------------


call s:load('init.rc.vim')
call s:load('editor.rc.vim')
call s:load('dein.rc.vim')
call s:load('terminal.rc.vim')
call s:load('deoplete.rc.vim')
call s:load('denite.rc.vim')
call s:load('lightline.rc.vim')
call s:load('color.rc.vim')
