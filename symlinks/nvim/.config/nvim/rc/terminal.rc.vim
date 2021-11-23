if has('nvim')
    set sh=zsh
    tnoremap <silent> <ESC> <C-\><C-n>
    command! -nargs=* T split | wincmd j | resize 20 | terminal <args>
    autocmd TermOpen * startinsert
elseif has('terminal')
    set sh=zsh
    tnoremap <silent> <ESC> <C-\><C-n>
    command! Term terminal ++close zsh
else
    command! Term VimShell
endif
