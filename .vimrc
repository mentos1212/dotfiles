"一般の設定
syntax on
filetype on
set nocompatible "vi互換をやめる
set clipboard=unnamed,unnamedplus " OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set clipboard+=unnamed "OSのクリップボードを使う
set mouse=a "マウス入力を受け付ける
set shellslash " Windows でもパスの区切り文字を / にする
set iminsert=0 " インサートモードから抜けると自動的にIMEをオフにする
set helplang& helplang=ja,en

" NeoBundleの設定
set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

""""" NeoBundle Plugins START """""
"util
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler' "ファイルエクスプローラ
"NeoBundle "ctrlpvim/ctrlp.vim" "ファイル名を指定して開く

"color scheme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/louver.vim'
NeoBundle 'vim-scripts/tango.vim'
NeoBundle 'chriskempson/tomorrow-theme'
NeoBundle 'vim-scripts/github-theme'
NeoBundle 'vim-scripts/vylight'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/pyte'
NeoBundle 'vim-scripts/summerfruit256.vim'
NeoBundle 'vim-scripts/proton'
NeoBundle 'hail2u/h2u_colorscheme'

""""" NeoBundle Plugins END """""

"markdown
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a Firefox'

"syntax check
NeoBundle 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
nnoremap <silent><Space>v :VimFiler -split -simple -winwidth=35 -no-quit<CR>

" ファイル処理関連の設定
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   "外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない
set backupskip=/tmp/*,/private/tmp/*" 

"画面表示の設定
set number         " 行番号を表示する
set ruler
"set cursorline     " カーソル行の背景色を変える
"set cursorcolumn   " カーソル位置のカラムの背景色を変える
set laststatus=2   " ステータス行を常に表示
set cmdheight=2    " メッセージ表示欄を2行確保
set showmatch      " 対応する括弧を強調表示
set helpheight=999 " ヘルプを画面いっぱいに開く
set list           " 不可視文字を表示
set listchars=tab:\|\ " 不可視文字の表示記号指定

"カラースキームの設定
autocmd ColorScheme * highlight LineNr ctermfg=239 " 行番号の色を変更
syntax enable
set background=light "色設定
colorscheme lucius  " カラースキーム設定

" タブ/インデントの設定
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set shiftwidth=2  " 自動インデントでずれる幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set nrformats-=octal

"カーソル移動関連の設定
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

"改行コードの自動認識
set fileformats=unix,dos,mac
set encoding=utf8

"ESCのバインド
noremap! <C-j> <ESC>
noremap <C-j> <ESC>

"Emacsキーバインドでのカーソル移動
"insert mode / command line mode
noremap! <C-a>  <Home>
noremap! <C-e>  <End>
noremap! <C-b>  <Left>
noremap! <C-f>  <Right>
noremap! <C-n>  <Down>
noremap! <C-p>  <UP>
inoremap <C-d>	<C-O>x
inoremap <expr> <C-k> "\<C-g>u".(col('.') == col('$') ? '<C-o>gJ' : '<C-o>D')

"normal mode / visual mode
noremap <C-a>  <Home>
noremap <C-e>  <End>
noremap <C-b>  <Left>
noremap <C-f>  <Right>
noremap <C-n>  <Down>
noremap <C-p>  <UP>

"全選択
inoremap <C-x>h <ESC>ggVG
nnoremap <C-x>h ggVG
"貼り付け
inoremap <C-y> <ESC>pi
vnoremap <C-w> d

"画面分割
inoremap <silent> <C-x>0 <ESC>:only<CR>i
noremap <silent> <C-x>2 <ESC>:sp<CR>i
inoremap <silent> <C-x>3 <ESC>:vsp<CR>i
inoremap <silent> <C-x>o <ESC><C-w>w<CR>i
inoremap <silent> <C-x>p <ESC><C-w>p<CR>i

" 画面送り
noremap <S-n> <C-f>
noremap <S-p> <C-b>
noremap <S-b> <C-d>
noremap <S-f> <C-u>

"md
autocmd FileType markdown inoremap <Space><Space> -
"php
autocmd FileType php inoremap <Space>[ ['']<Left><Left>
autocmd FileType php inoremap <C-4> $_
