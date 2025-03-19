set t_Co=256
if has('termguicolors') && $COLORTERM == 'truecolor'
    set termguicolors
    if !has('nvim')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
endif

set background=dark
colorscheme hybrid

if has('gui_running') || has('termguicolors')
    highlight specialkey term=none cterm=none gui=none
else
    highlight specialkey term=none cterm=none
endif
