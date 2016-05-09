" Prefix keyはC-u
nnoremap [unite] <Nop>
nmap <C-u> [unite]

let g:unite_enable_start_insert=1         " insertモードで起動
let g:unite_source_file_mru_limit = 200
" バッファ一覧
nnoremap <silent> [unite]<C-b>   :<C-u>Unite buffer<CR>
" バッファ+最近開いたファイル+ブックマーク
nnoremap <silent> [unite]<C-r>   :<C-u>Unite buffer file_mru bookmark<CR>
" vimを開いたディレクトリ(カレントディレクトリ) にあるファイル一覧
nnoremap <silent> [unite]<C-g>   :<C-u>Unite file<CR>
" 現在開いているファイル（バッファ）があるディレクトリのファイル一覧
"innoremap <silent> [unite]<C-f>   :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" 現在のバッファと同じ階層にファイル作成
nnoremap <silent> [unite]<C-n>   :<C-u>UniteWithBufferDir file/new<CR>
" yankの履歴
nnoremap <silent> [unite]<C-y> :<C-u>Unite history/yank<CR>
" 現在のバッファ内検索（絞り込み）
nnoremap <silent> [unite]/ :<C-u>Unite -buffer-name=search line<CR>

let g:unite_source_rec_min_cache_files = 20
let g:unite_source_rec_max_cache_files = 3000

" ウィンドウを左右に分割して右側に開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('right')
au FileType unite inoremap <silent> <buffer> <expr> <C-o> unite#do_action('right')
" ウィンドウを上下に分割して下側に開く
"au FileType unite nnoremap <silent> <buffer> <expr> <C-x> unite#do_action('bellow')
"au FileType unite inoremap <silent> <buffer> <expr> <C-x> unite#do_action('bellow')

" カレントディレクトリ以下のファイル名検索
function! DispatchUniteFileRecAsyncOrGit()
  if isdirectory(getcwd()."/.git")
    Unite file_rec/git
  else
    Unite file_rec/async:!
  endif
endfunction
" 画像とドットディレクトリは対象外
" call unite#custom#source('file_rec,file_rec/async,file_rec/git','ignore_pattern','\(png\|gif\|jpeg\|jpg\|\.[^\/]*\/.*\)$')
" nnoremap <silent> [unite]<C-f> :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>
"
" " いい感じのディレクトリ名検索
" call unite#custom#source('directory,directory_mru,directory_rec/async', 'ignore_pattern', '\(\..*\)$') " ドットディレクトリは対象外
" nnoremap <silent> [unite]<C-d> :<C-u>Unite -default-action=vimfiler directory directory_mru directory_rec/async<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nocolor --nogroup'
  let g:unite_source_grep_recursive_opt = ''
endif
let g:unite_source_grep_max_candidates = 200

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" ディレクトリを指定してgrep検索
nnoremap <silent> ,dg  :<C-u>Unite grep -buffer-name=search-buffer<CR>
" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>
" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

