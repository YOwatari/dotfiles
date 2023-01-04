function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : deoplete#manual_complete()
inoremap <silent><expr> <C-n> pumvisible() ? "\<C-u>deoplete#manual_complete()" : deoplete#manual_complete()
inoremap <expr><CR>           pumvisible() ? deoplete#close_popup() : "<CR>"
inoremap <expr><C-h>          deoplete#smart_close_popup() . "\<C-h>"
inoremap <expr><BS>           deoplete#smart_close_popup() . "\<C-h>"
inoremap <expr><C-g>          deoplete#cancel_popup()
inoremap <expr><C-e>          deoplete#cancel_popup()

call deoplete#custom#option('enable_at_startup', v:true)
call deoplete#custom#option('auto_complete_delay', 0)
call deoplete#custom#option('min_pattern_length', 3)
call deoplete#custom#option('camel_case', v:true)
call deoplete#custom#option('refresh_always', v:true)
call deoplete#custom#option('max_list', 200)

"
" lsp
"

let g:lsp_setting_servers_dir = '~/.lsp_servers'
let g:lsp_preview_float = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 0
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 0
let g:python_host_prog = expand('~/.pyenv/versions/neovim-2/bin/python')
let g:python3_host_prog = expand('~/.pyenv/versions/neovim-3/bin/python')

nnoremap [lsp] <Nop>
nmap <C-k><C-l> [lsp]
nnoremap [lsp]h     :<C-u>LspHover<CR>
nnoremap [lsp]<C-h> :<C-u>LspHover<CR>
nnoremap [lsp]d     :<C-u>LspDefinition<CR>
nnoremap [lsp]<C-d> :<C-u>LspDefinition<CR>
nnoremap [lsp]r     :<C-u>LspRename<CR>
nnoremap [lsp]<C-r> :<C-u>LspRename<CR>
