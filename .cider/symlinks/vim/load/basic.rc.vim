" バッファ移動
nnoremap <silent>bv :bprevious<CR>
nnoremap <silent>bn :bnext<CR>
nnoremap <silent>bb :b#<CR>

" ファイルタイプ
au BufNewFile,BufRead *.md setfiletype markdown
au BufNewFile,BufRead *.twig setfiletype htmljinja
au BufNewFile,BufRead *.pp setfiletype puppet
au BufNewFile,BufRead */nginx/conf/*,nginx.conf* setfiletype nginx
au BufNewFile,BufRead Dockerfile* setfiletype dockerfile
au BufNewFile,BufRead keepalived.conf* setfiletype keepalived

" 行番号とシンタックスハイライト
set number
syntax enable

" インデント
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
au BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.css,*.scss set tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.pp set tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.json set tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.rb set tabstop=2 shiftwidth=2 softtabstop=2

" 検索関連
set ignorecase
set smartcase
set incsearch
set hlsearch
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" カーソル行
set cursorline
augroup cch
autocmd! cch
autocmd WinLeave * set nocursorline
autocmd WinEnter,BufRead * set cursorline
augroup END
:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" Esc2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" 保存時に行末空白を削除
autocmd BufWritePre * :%s/\s\+$//e

"tabとeolの可視化
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«

" バックスペース有効化
set backspace=indent,eol,start

" スペルチェック
set spelllang=en,cjk

" クリップボード
set clipboard=unnamed
