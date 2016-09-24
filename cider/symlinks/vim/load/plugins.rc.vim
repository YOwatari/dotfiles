" Unite
let g:unite_data_directory = '~/.vim/cache/unite'
call unite#custom#profile('default', 'context', {
            \ 'start_insert': 1,
            \ 'ignore_case': 1,
            \ 'smart_case': 1,
            \ })
call unite#custom#profile('files', 'context', {
            \ 'smart_case': 0,
            \})

" neoyank
let g:neoyank#file = g:unite_data_directory . '/neoyank'

" neomru
let g:neomru#file_mru_limit = 200
let g:neomru#file_mru_path = g:unite_data_directory . '/neomru/file'
let g:neomru#directory_mru_limit = 200
let g:neomru#directory_mru_path = g:unite_data_directory . '/neomru/directory'

if executable('hw')
  let g:unite_source_grep_command = 'hw'
  let g:unite_source_grep_default_opts = '--no-group --no-color'
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,gc :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap <silent> ,gr :<C-u>UniteResume search-buffer<CR>
nnoremap <silent> ,gs :<C-u>Unite giti<CR>


" NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap <silent><C-f> :NERDTreeFind<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeBookmarksFile = '~/.vim/.NERDTreeBookmarks'


" ctrlp
let g:ctrp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = '~/.vim/cache/ctrlp'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)$',
            \ 'file': '\v\.(exe|so|dll|swp|zip|jpg|png|gif)$',
            \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
            \ }


" easymotion
nmap e <Plug>(easymotion-s2)
xmap e <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)


" multiple-cursors
function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
endfunction

function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
endfunction


" vim-quickrun
let g:quickrun_config = {}
let g:quickrun_config.markdown = {
     \ 'outputter' : 'null',
     \ 'command'   : 'open',
     \ 'cmdopt'    : '-a',
     \ 'args'      : 'Marked',
     \ 'exec'      : '%c %o %a %s',
     \ }


" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_loc_list_height = 5
let g:syntastic_quiet_messages  = { 'level': 'warnings' }

let g:syntastic_aggregate_errors = 1

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:syntastic_php_checkers   = ['phpcs']
let g:syntastic_php_phpcs_args = '--standard=psr2'
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['php'] }

let g:syntastic_puppet_checkers = ['puppet', 'puppetlint']
let g:syntastic_puppet_puppetlint_args = '--no-80chars-check --no-autoloader_layout-check'
let g:syntastic_check_map = { 'mode': 'active', 'active_filetypes': ['puppet'] }


" neocomplete
let g:neocomplete#data_directory = '~/.vim/cache/neocomplete'
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

let g:neocomplete#max_list = 20
let g:neocomplete#sources#syntax#min_keyword_length = 3

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.go = '[^.[:digit:] \t]\.\w*'

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.markdown = ''
let g:neocomplete#sources#omni#input_patterns.gitcommit = ''


" markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_codeblock_syntax=0


" jsx
let g:jsx_ext_required = 0


" php
" inoremap <C-P> <Esc>:call PhpDocSingle()<CR>i
" nnoremap <C-P> :call PhpDocSingle()<CR>
" vnoremap <C-P> :call PhpDocSingle()<CR>


" typescript
let g:typescript_indent_disable = 1


" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_comand = "goimports"

let g:go_list_type = "quickfix"

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>e <Plug>(go-rename)


