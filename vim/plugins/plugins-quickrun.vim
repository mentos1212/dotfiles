" 画面を左右に分割して右側に実行結果を出力
let g:quickrun_config={'*': {'split': 'vertical'}}
set splitright
" プログラム実行中でもソース編集可能にする（非同期実行）
let g:quickrun_config._={ 'runner':'vimproc',
\       "runner/vimproc/updatetime" : 10,
\       "outputter/buffer/close_on_empty" : 1,
\ }
" goの場合は`go run *.go`を実行する
let g:quickrun_config['go'] = {'command' : 'go', 'exec' : ['%c run *.go']}

nnoremap <silent> <C-r> :QuickRun<CR>
