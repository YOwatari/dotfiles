set laststatus=2
set noshowmode
set t_Co=256
set encoding=utf-8

let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


colorscheme hybrid_reverse
