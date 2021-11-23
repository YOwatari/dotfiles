autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d       denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p       denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q       denite#do_map('quit')
    nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction


let s:denite_win_width_percent = 0.85
let s:denite_win_height_percent = 0.7
let s:floating_setting = {
    \ 'split': 'floating',
    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
    \ 'wincol': float2nr((&columns * - (&columns * s:denite_win_width_percent)) / 2),
    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ }
call denite#custom#option('default', s:floating_setting)
call denite#custom#option('grep-buffer-denite',s:floating_setting)


nnoremap [denite] <Nop>
nmap <C-k><C-d> [denite]
nnoremap [denite]<C-f> :<C-u>Denite<Space>file<CR>
nnoremap [denite]<C-b> :<C-u>Denite<Space>buffer<CR>
nnoremap [denite]<C-h> :<C-u>Denite<Space>file_mru<CR>
nnoremap [denite]<C-y> :<C-u>Denite<Space>neoyank<CR>
nnoremap [denite]<C-r> :<C-u>Denite -buffer/-name=register register<CR>
nnoremap [denite]<C-c> :<C-u>DeniteBufferDir file<CR>
nnoremap [denite]f     :<C-u>Denite<Space>file<CR>
nnoremap [denite]b     :<C-u>Denite<Space>buffer<CR>
nnoremap [denite]h     :<C-u>Denite<Space>file_mru<CR>
nnoremap [denite]y     :<C-u>Denite<Space>neoyank<CR>
nnoremap [denite]r     :<C-u>Denite -buffer-name=register register<CR>
nnoremap [denite]c     :<C-u>DeniteBufferDir -buffer-name=files file<CR>

nnoremap <C-k><C-b> :Denite<Space>buffer<CR>


command! Dgrep execute(':Denite grep -buffer-name=grep-buffer-denite')
command! Dresume execute(':Denite -resume -buffer-name=grep-buffer-denite')
command! Dnext execute(':Denite -resume -buffer-name=grep-buffer-denite -select=+1 -immediately')
command! Dprev execute(':Denite -resume -buffer-name=grep-buffer-denite -select=-1 -immediately')


call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'default_opts', ['-S', '--vimgrep', '--no-heading'])


nnoremap [denite]<C-g> :Denite grep -buffer-name=grep-buffer-denite<CR>
nnoremap [denite]<C-r> :Denite grep -resume -buffer-name=grep-buffer-denite<CR>
nnoremap [denite]<C-n> :Denite grep -resume -buffer-name=grep-buffer-denite -select=+1 -immediately<CR>
nnoremap [denite]<C-p> :Denite grep -resume -buffer-name=grep-buffer-denite -select=-1 -immediately<CR>
nnoremap [denite]j     :Denite grep -buffer-name=grep-buffer-denite<CR>
nnoremap [denite]r     :Denite grep -resume -buffer-name=grep-buffer-denite<CR>
nnoremap [denite]n     :Denite grep -resume -buffer-name=grep-buffer-denite -select=+1 -immediately<CR>
nnoremap [denite]p     :Denite grep -resume -buffer-name=grep-buffer-denite -select=-1 -immediately<CR>
