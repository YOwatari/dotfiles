let g:lsp_setting_servers_dir = '~/.lsp_servers'
let g:lsp_preview_float = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 0
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 0

nnoremap [lsp] <Nop>
nmap <C-k><C-l> [lsp]
nnoremap [lsp]h     :<C-u>LspHover<CR>
nnoremap [lsp]<C-h> :<C-u>LspHover<CR>
nnoremap [lsp]d     :<C-u>LspDefinition<CR>
nnoremap [lsp]<C-d> :<C-u>LspDefinition<CR>
nnoremap [lsp]r     :<C-u>LspRename<CR>
nnoremap [lsp]<C-r> :<C-u>LspRename<CR>
