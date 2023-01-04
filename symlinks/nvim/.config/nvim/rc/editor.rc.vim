" ファイルタイプ
au BufNewFile,BufRead *.md set filetype=markdown

" インデント
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" 表示
set number
set showmatch
set cursorline
set title
set showmode
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«
set spell
set spelllang+=cjk
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap
hi SpellCap cterm=underline,bold

" ステータスライン
set laststatus=2
set noshowmode
set statusline=%F%m%r%h%w\%=[FILETYPE=%Y][ENC=%{&fenc}][%{&ff}]%=%c,\%l/%L

" 検索
set wrapscan
set ignorecase
set smartcase
set hlsearch
set incsearch
set grepprg=internal
nnoremap <ESC><ESC> :sign unplace *<CR>:nohlsearch<CR><ESC>

" エンコーディング
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

" diff
function! SetDiffMode()
    if &diff
        setlocal nospell
        setlocal wrap<
    endif
endfunction
autocmd VimEnter,FilterWritePre * call SetDiffMode()

set splitright
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
