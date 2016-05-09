if &compatible
  set nocompatible
endif

" deinのpath
let s:dein_path = expand('~/.cache/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'

" deinがない場合はfetch
if !isdirectory(s:dein_repo_path)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
endif

" runtimepathにdeinを追加
execute 'set runtimepath^=' . s:dein_repo_path

" pluginの読み込み
call dein#begin(s:dein_path)
call dein#load_toml('~/dotfiles/vim/dein/plugins.toml', {'lazy': 0})
call dein#end()

" installされていないpluginをinstall
if dein#check_install()
  call dein#install()
endif

" 全ての読み込みが終わったタイミングでpost_sourceフックを実行
autocmd VimEnter * call dein#call_hook('post_source')

" Required:
filetype plugin indent on
syntax enable

