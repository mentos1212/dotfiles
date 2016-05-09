" 画面移動（tmux navigator）
let g:tmux_navigator_no_mappings = 1 "tmux navigatorのデフォルトバインドを無効化
"let g:tmux_navigator_save_on_switch = 1 " 画面移動の際に自動でファイル内容を保存
"
set <C-Right>=\e[1;*C "tmuxから送られるCtrl+arrowの設定(Shift+arrowにも使える）
set <C-Left>=\e[1;*D
" set <C-Up>=\e[1;*A
" set <C-Down>=\e[1;*B

nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-UP> :TmuxNavigateUp<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

