" 一般の設定
syntax on
set nocompatible                  "vi互換をやめる
set clipboard=unnamed,unnamedplus " OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set clipboard+=unnamed            "OSのクリップボードを使う
set clipboard+=autoselect
set mouse=a                       "マウス入力を受け付ける
set shellslash                    "Windows でもパスの区切り文字を / にする
set iminsert=0                    " インサートモードから抜けると自動的にIMEをオフにする
set helplang& helplang=ja,en
set timeout timeoutlen=150         " NeocompleteのせいでESCの効きが悪くなる問題の対応

" ファイル処理関連の設定
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   "外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない
set backupskip=/tmp/*,/private/tmp/*"

" 画面表示の設定
set number         " 行番号を表示する
set cursorline     " カーソル行の背景色を変える
set cursorcolumn   " カーソル位置のカラムの背景色を変える
set laststatus=2   " ステータス行を常に表示
"set cmdheight=2    " メッセージ表示欄を2行確保
set showmatch      " 対応する括弧を強調表示
set helpheight=999 " ヘルプを画面いっぱいに開く

" 検索ハイライトの色設定
hi Search cterm=NONE ctermfg=gray ctermbg=red

" タブ/インデントの設定
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=4     " 画面上でタブ文字が占める幅
set shiftwidth=4  " 自動インデントでずれる幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set nrformats-=octal

" カーソル移動関連の設定
set backspace=indent,eol,start  "BSでなんでも消せるようにする
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う

set foldenable
set foldmethod=indent
set foldlevel=10
set foldnestmax=10
set foldcolumn=2

" コマンドラインの設定
" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full
" コマンドラインの履歴を10000件保存する
set history=10000

" ビープの設定
set visualbell t_vb= "ビープ音すべてを無効にする
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない

" 検索/置換の設定
set hlsearch   " 検索文字列をハイライトする
set incsearch  " インクリメンタルサーチを行う
set ignorecase " 大文字と小文字を区別しない
set smartcase  " 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan   " 最後尾まで検索を終えたら次の検索で先頭に移る
set gdefault   " 置換の時 g オプションをデフォルトで有効にする

" 改行コードの自動認識
set fileformats=unix,dos,mac
set encoding=utf8

" タブ、空白、改行の可視化
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%

" 全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

" 移動系keymap -----------------------------------------------
" Emacsキーバインドでのカーソル移動
" insert mode / command line mode
noremap! <C-a>  <Home>
noremap! <C-e>  <End>
noremap! <C-b>  <Left>
noremap! <C-f>  <Right>
noremap! <C-n>  <Down>
noremap! <C-p>  <UP>
inoremap <C-d>	<C-O>x
inoremap <expr> <C-k> "\<C-g>u".(col('.') == col('$') ? '<C-o>gJ' : '<C-o>D')

" normal mode / visual mode
noremap <C-a>  <Home>
noremap <C-e>  <End>
noremap <C-b>  <Left>
noremap <C-f>  <Right>
" noremap <C-n>  <Down>
"noremap <C-p>  <UP>
"
" ページ送り、半ページ送り(tmux内でM-k -> ˚, M-j -> ∆, M-K -> , M-J -> Ô）
noremap ∆ <C-f>
inoremap ∆ <ESC><C-f>i
noremap ˚ <C-b>
inoremap ˚ <ESC><C-b>i
noremap Ô <C-d>
inoremap Ô <ESC><C-d>i
noremap  <C-u>
inoremap  <ESC><C-u>i
" Uでredo
nnoremap <S-u> :redo<CR>

" w/q/y/pなど -------------------------------------------
" 書き込み・終了系
nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>wq :wq<CR>
nnoremap <Space><Space>q :q!<CR>

" 全選択
nnoremap <Space>a ggVG
" 全選択してフォーマット
nnoremap <Space>i gg=G
" remoteのyankをローカルのクリップボードに転送
nnoremap <Space>y :call system('nc localhost 8377', @0)<CR>
" ローカルのクリップボードの内容をpaste(ローカル限定)
nnoremap <Space>p "*p

" 無名レジスタにいれずにdelete
nnoremap <Space>d "_d
vnoremap <Space>d "_d
nnoremap <Space>dd "_dd

" yankレジスタの内容をpaste
nnoremap <Space>p "0p
nnoremap <Space>P "0P

" yankやpaste時に対象文字列の最後にカーソルを移動させる
" vnoremap <silent> y y`]
" vnoremap <silent> p p`]
" nnoremap <silent> p p`]
"
" c*でカーソル下のキーワードを置換
nnoremap <expr> c* ':%s ;\<' . expand('<cword>') . '\>;'
vnoremap <expr> c* ':s ;\<' . expand('<cword>') . '\>;'

" カーソルの下の単語をヤンクした文字列で置換
nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> cy   ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cy   c<C-r>0<ESC>:let@/=@1<CR>:noh<CR>

" ノーマルモードで空行を挿入(インデント・コメントアウトを保持する/しない)
nnoremap <CR> o<ESC>
nnoremap O :<C-u>call append(expand('.'), '')<CR>j

" 数字インクリメントのバインド変更
nnoremap <C-l> <C-a>

" 画面・バッファ--------------------------------------------------
nnoremap <C-r> <NOP>
nnoremap <silent> <C-r><C-s> :sp<CR>    " 上下に分割
nnoremap <silent> <C-r><C-n> :vsp<CR>   " 左右に分割
nnoremap <silent> <C-r><C-o> :close<CR> " 現在のウィンドウを閉じる
nnoremap <silent> <C-r><C-u> :only<CR>  " 現在のウィンドウ以外を閉じる
nnoremap <silent> <C-r><C-l> <C-w>L     " 現在のウィンドウを右に移動

nnoremap <silent> <C-r><C-h> <C-w>H     " 現在のウィンドウを左に移動

" バッファ関連
nnoremap <silent> sp :bprevious<CR> " 戻る
nnoremap <silent> sn :bnext<CR>     " 進む
nnoremap <silent> sd :bdelete<CR>     " 削除

" 自動で開いたファイルのディレクトリに移動
au BufEnter * execute 'lcd ' fnameescape(expand('%:p:h'))

" コマンド履歴、検索履歴の設定  ---------------------------------
" q:、q/、q? は暴発しがちなので無効化
nnoremap q: <NOP>
nnoremap q/ <NOP>
nnoremap q? <NOP>
nnoremap <F5> q: " F5でコマンド履歴を開く
nnoremap <F6> q/ " F6で検索履歴を開く（前方検索になる）
nnoremap <F7> q? " F7で検索履歴を開く（後方検索になる）

" record機能も暴発しがちなので無効化
nnoremap q  <NOP>

"その他Util  ---------------------------------------------------
" autocmd groupを作成
augroup MyAutoCmd
  autocmd!
augroup END

" source .vimrc
nnoremap <C-r>r :source ~/.vimrc<CR>

" markdownのft設定
au BufRead,BufNewFile *.md set filetype=markdown

" ペースト時に自動でpaste madeにする
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"
    function! XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction
    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif
" insertからnormalに戻った時に自動でペーストモードを抜ける
autocmd InsertLeave * set nopaste

" <Space>cd で編集ファイルのカレントディレクトリへと移動
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction
nnoremap <silent> <Space>cd :<C-u>CD<CR>

" filetypeの検出を有効化
filetype on
filetype plugin indent on
syntax enable

