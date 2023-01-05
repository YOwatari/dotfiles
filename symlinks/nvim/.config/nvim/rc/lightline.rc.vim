" https://github.com/itchyny/lightline.vim/blob/master/colorscheme.md#powerlineish
let g:lightline = {
      \ 'colorscheme': 'powerlineish',
      \ 'active': {
      \   'left':  [ [ 'mode', 'paste' ],
      \              [ 'fugitive', 'readonly', 'absolutepath', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'lineinfo2' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ],
      \ },
      \ 'inactive': {
      \   'left':  [ [ 'fugitive', 'readonly', 'absolutepath', 'modified' ] ],
      \   'right': [ [ 'lineinfo2', 'lineinfo' ],
      \              [ 'filetype' ] ]
      \ },
      \ 'component': {
      \   'rows': '%L',
      \   'lineinfo2': '%3p%%(%l/%L)',
      \ },
      \ 'component_function': {
      \   'absolutepath': 'LightLineAbsolutePath',
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \ },
      \ }

function! LightLineAbsolutePath()
  let a = substitute(expand('%:p'), $HOME, '~', '')
  if a == ""
    return 'Untitled'
  elseif strlen(a) > 40
    return a[strlen(a)-40:]
  else
    return a
  endif
endfunction

function! LightLineFugitive()
  let branch = FugitiveHead()
  return branch !=# '' ? "\u2b60 ".branch : ''
endfunction

function! LightLineReadonly()
  return &readonly ? "\u2b64" : ''
endfunction

function! LightLineTabInfo()
  return lightline#tabs()
endfunction
