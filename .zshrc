# 汎用設定
# ----------------------------
# 言語設定
# export LANG=ja_JP.UTF-8

# エディタはvim
export EDITOR=vim

# ビープ音を消す
setopt no_beep
setopt nolistbeep

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# '#' 以降をコメントとして扱う
setopt interactive_comments

# emacs key bind
bindkey -e

# カーソル左消去
bindkey "^u" backward-kill-line

# Ctrl + r で履歴さかのぼり
bindkey "^R" history-incremental-search-backward

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# ディレクトリ名だけでcdする
setopt auto_cd

# cdの履歴を記録
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# C-s, C-qによるフロー制御を使わないようにする
setopt NO_FLOW_CONTROL

# 補完関連
# ---------------------------
autoload -Uz compinit
compinit -C #for git-completion

# Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
bindkey "^[[Z" reverse-menu-complete

# 補完候補を省スペースに
setopt list_packed

# 補完時に大文字小文字を無視
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu

# エイリアスのコマンドも補完対象とする
setopt complete_aliases


# 履歴関連
# ----------------------------
HISTFILE=~/.zsh_history
HISTSIZE=200000
SAVEHIST=200000

# 重複する履歴は無視
setopt hist_ignore_dups

# 履歴を共有
setopt share_history

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

 # ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt append_history

# 重複するコマンドが記憶されるとき、古い方を削除する
setopt hist_ignore_all_dups

# 重複するコマンドが保存されるとき、古い方を削除する
setopt hist_save_no_dups

# 開始時刻と実行時間を記録
setopt extended_history

# 色の設定
# ---------------------------
# 色の変数で${fg[red]}などを使えるようにする(8色限定)
autoload -Uz colors; colors
# lsしたときの色設定
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
# lsしたときに自動で色がつく
export CLICOLOR=true
# 補完候補にも同様の色付けを設定
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# manコマンドに色をつける
export MANPAGER='less -R'
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# colordiffがあれば使う
if [ which colordiff >/dev/null 2>&1 ]; then
  alias diff='colordiff'
fi

# 色の定義
ESC="\x1b[" # "\033["や"\e["でも動作する場合があるが、x1bが最も安全
PREFIX_256="38;5;"
RESET="${ESC}0m"
# RED="${ESC}31m"
RED="${ESC}${PREFIX_256}196m"
GREEN="${ESC}32m"
YELLOW="${ESC}33m"
# BLUE="${ESC}34m"
BLUE="${ESC}${PREFIX_256}33m"
MAGENTA="${ESC}35m"
CYAN="${ESC}36m"
LIGHT_GRAY="${ESC}37m"

# tailやlessでログを表示したときに色をつける
alias -g C='| sed -u -e "\
    s/\(ERROR\)/${RED}\1${RESET}/gi; \
    s/\(DEBUG\)/${YELLOW}\1${RESET}/gi; \
    s/\(INFO\)/${BLUE}\1${RESET}/gi; \
    s/\(FAILE\?D\?\)/${RED}\1${RESET}/gi \
    "'

# ログファイルを色付けしてless
function lec(){
    cat $1 C | less -R
}

# プロンプトの設定
# ----------------------------
# コマンドを実行するときに右プロンプトを消す
setopt transient_rprompt
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

autoload -Uz add-zsh-hook # add-zsh-hookを有効化
autoload -Uz vcs_info     # version control systemの情報を表示するモジュール
autoload -Uz is-at-least  # zshのバージョン判定を行うモジュール

# 以下の3つのメッセージをエクスポートする
#   $vcs_info_msg_0_ : 通常メッセージ用 (緑)
#   $vcs_info_msg_1_ : 警告メッセージ用 (黄色)
#   $vcs_info_msg_2_ : エラーメッセージ用 (赤)
zstyle ':vcs_info:*' max-exports 3

# 各vcs共通の設定
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '[%s: %b]'
zstyle ':vcs_info:*' actionformats '[%s: %b|%a]'

if is-at-least 4.3.10; then
    # gitの設定
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr " +"    # Indexに変更がある状態（addはしたがcommitしていない）%cで受ける
    zstyle ':vcs_info:git:*' unstagedstr " -"  # WorkingTreeに変更がある状態（addしていない変更がある）%uで受ける
    zstyle ':vcs_info:git:*' formats '[%b]' '%c%u%m' # $vcs_info_msg_n_で表示する文字列 %bはカレントブランチ名
    zstyle ':vcs_info:git:*' actionformats '[%b]' '%c%u%m' ' <!%a>' # rebase中やmerge中など特別な状態の場合
fi

# プロンプトを表示する直前に走るhookを設定
function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info 2>/dev/null
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_" # psvar[1]は%1vで受ける
    [[ -n "$vcs_info_msg_1_" ]] && psvar[2]="$vcs_info_msg_1_" # psvar[2]は%2vで受ける
    [[ -n "$vcs_info_msg_2_" ]] && psvar[3]="$vcs_info_msg_2_" # psvar[3]は%3vで受ける
}
add-zsh-hook precmd _update_vcs_info_msg

# 2段プロンプト設定
host_block="%B%F{33}%n@local%f%b"
[[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]] && host_block="%B%F{196}${HOST%.*.*.yahoo.co.jp}%f%b"
path_block="%B%F{green}%~%f%b"
git_block="%1(v|%B%F{208}%1v%f%F{yellow}%2v%f%F{196}%3v%f%b |)"
PROMPT="%F{blue}>>%f "${host_block}" "${path_block}" "${git_block}"[%D %*]
%F{blue}$%f "
PROMPT2='%F{blue}$> %f'

# プロンプトの時刻表示をコマンド実行時に更新
re-prompt() {
    zle .reset-prompt
    zle .accept-line
}
zle -N accept-line re-prompt

# TMUX関連
# ----------------------------
# ディレクトリを移動時にtmuxのwindow nameをディレクトリ名に変更
add-zsh-hook chpwd auto_tmux_rename
auto_tmux_rename(){
    if [[ -n $(printenv TMUX) ]]; then
        tmux rename-window -- "${PWD##*/}"
    fi
}

# SSHログイン時にtmuxのwindow-nameをログイン先ホスト名にrename
function ssh() {
    if [[ -n $(printenv TMUX) ]]; then
        local window_name=$(tmux display -p '#{window_name}')
        domain=$(echo $@[-1] | cut -d. -f1)
        tmux rename-window -- "$domain" # zsh specified
        tmux set-window-option -t $(tmux display-message -p "#I") window-status-format "#[fg=colour011][#I:#W]"
        command ssh $@
        tmux rename-window $window_name
        tmux set-window-option -t $(tmux display-message -p "#I") window-status-format "#[bg=colour27][#I:#W]"
    else
        command ssh $@
    fi
}

# remoteのtmux attachでagent転送が切れないようにする
agent="$HOME/.ssh/agent"
if [ -S "$SSH_AUTH_SOCK" ]; then
    case $SSH_AUTH_SOCK in
        /tmp/*/agent.[0-9]*)
            ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
    esac
elif [ -S $agent ]; then
    export SSH_AUTH_SOCK=$agent
else
    echo "no ssh-agent"
fi

# cdrの設定
# ----------------------------
# cdrを有効にする
if is-at-least 4.3.11; then
    autoload -Uz chpwd_recent_dirs cdr
    add-zsh-hook chpwd chpwd_recent_dirs
    # cdr の設定
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-max 500
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
    zstyle ':chpwd:*' recent-dirs-pushd true
fi

# pecoの設定
# ----------------------------
# tac commandがないときはtail -rで代用する
if which tac > /dev/null 2>&1; then
else
    alias tac='tail -r'
fi

# コマンド履歴検索
function peco-history-selection() {
    BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

# コマンドマスター履歴検索
function peco-master-history-selection() {
    BUFFER=`tac ~/.zsh_history_master | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

# 過去に行ったことのあるディレクトリを検索して移動（上記のcdrの設定が必要）
function peco-cdr () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}

# カレントディレクトリ以下のファイル検索（dotファイルを除く）
function peco-find() {
    local l=$(\find . -maxdepth 8 -a \! -regex '.*/\..*' | peco)
    BUFFER="${LBUFFER}${l}"
    CURSOR=$#BUFFER
    zle clear-screen
}

# カレントディレクトリ以下のファイル検索（dotファイルを含む）
function peco-find-all() {
    local l=$(\find . -maxdepth 8 | peco)
    BUFFER="${LBUFFER}${l}"
    CURSOR=$#BUFFER
    zle clear-screen
}

# プロセスを検索してpidを取得（主にkill用。危険なのでkiilは自分でうつ）
function peco-kill(){
    FILTERD=$(ps aux | peco | awk '{print $2}')
    BUFFER=${BUFFER}${FILTERD}
    CURSOR=$#BUFFER
#   --- Too dangerous!! ---
#    proc=`ps aux | peco`
#    pid=`echo "$proc" | awk '{print $2}'`
#    echo "kill pid:$pid. [$proc]"
#    kill $pid
}

# gitのコミットログを選択してhash値を取得
function git-hash(){
    FILTERD=$(git log --oneline --branches | peco | awk '{print $1}')
    BUFFER=${BUFFER}${FILTERD}
    CURSOR=$#BUFFER
}

# gitのコミットログを選択してcherry-pick
function git-cherry-pick(){
    FILTERD=$(git log --oneline --branches | peco | awk '{print $1}')
    BUFFER=${BUFFER}"git cherry-pick "${FILTERD}
    CURSOR=$#BUFFER
    zle accept-line
    zle clear-screen
}

# git変更があったファイル名を取得
function git-changed-files(){
    FILTERD=$(git status --short | peco | awk '{print $2}')
    BUFFER=${BUFFER}${FILTERD}
    CURSOR=$#BUFFER
}

# checkoutしたことのあるブランチを指定してcheckout
function git-checkout-branch(){
    FILTERD=$(git reflog | grep checkout | cut -d' ' -f8 | awk '!a[$0]++' | peco)
    BUFFER=${BUFFER}"git checkout "${FILTERD}
    CURSOR=$#BUFFER
    zle accept-line
    zle clear-screen
}

# tmuxのsessionを選択してattach
function tmux-session-attach(){
    local session=$(tmux ls < /dev/null | peco | awk '{print $1}' | tr -d :)
    BUFFER="tmux a -t ${session}"
    zle accept-line
    zle clear-screen
}

# git commitでコミットメッセージ欄まで自動で入れる
function git-commit(){
    # gitリポジトリ配下でないならreturn
    if [ -z $(git rev-parse --git-dir 2> /dev/null) ]; then
        return
    fi
    msg="git commit -m \"\""
    # hub配下のリポジトリでブランチ名にHUB-/FAAS-が含まれている場合にブランチ名をつける
    if $(git config -l | grep remote.origin.url | grep -q -e :hub\/ -e :FaaS\/); then
        branch=$(git rev-parse --abbrev-ref HEAD)
        if $(echo $branch | grep -q -e HUB- -e FAAS-); then
            prefix=$(echo $branch | sed -e "s/dev-//g")
            msg="git commit -m \"[$prefix]\""
        fi
    fi
    BUFFER=${BUFFER}$msg
    CURSOR=$#BUFFER
}

# docker psをpecoで選択してCONTAINER IDを取得
function docker-ps(){
    FILTERD=$(docker ps -a | peco | awk '{print $1}')
    BUFFER=${BUFFER}${FILTERD}
    CURSOR=$#BUFFER
}

# docker psでCONTAINER IDを取得してそのコンテナに入る
function docker-exec(){
    local container_id=$(docker ps -a | peco | awk '{print $1}')
    BUFFER="docker exec -it $container_id bash"
    zle accept-line
    zle clear-screen
}

# docker psでCONTAINER IDを取得してrm -fを入力
function docker-rm(){
    FILTERD=$(docker ps -a | peco | awk '{print $1}')
    BUFFER="docker rm -f "${FILTERD}
    CURSOR=$#BUFFER
}

# docker imagesでIMAGE IDを取得してrm -fを入力
function docker-rmi(){
    FILTERD=$(docker images | peco | awk '{print $3}')
    BUFFER="docker rmi -f "${FILTERD}
    CURSOR=$#BUFFER
}

# peco関連のキーバインド
if [ -e /usr/local/bin/peco ]; then
    zle -N peco-history-selection
    bindkey '^r' peco-history-selection
    zle -N peco-master-history-selection
    bindkey '^[r' peco-master-history-selection
    zle -N peco-cdr
    bindkey '^u^r' peco-cdr
    zle -N peco-find
    bindkey '^u^f' peco-find
    zle -N peco-find-all
    bindkey '^u^a' peco-find-all
    zle -N peco-kill
    bindkey '^u^k' peco-kill
    zle -N git-hash
    bindkey '^g^h' git-hash
    zle -N git-cherry-pick
    bindkey '^g^p' git-cherry-pick
    zle -N git-changed-files
    bindkey '^g^f' git-changed-files
    zle -N git-checkout-branch
    bindkey '^g^r' git-checkout-branch
    zle -N tmux-session-attach
    bindkey '^u^i' tmux-session-attach
    zle -N git-commit
    bindkey '^g^o' git-commit
    zle -N docker-ps
    bindkey '^o^p' docker-ps
    zle -N docker-exec
    bindkey '^o^e' docker-exec
    zle -N docker-rm
    bindkey '^o^k' docker-rm
    zle -N docker-rmi
    bindkey '^o^i' docker-rmi
fi


# C-zでfg(vimバインドと共通化)
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# 移動・その他
# ----------------------------
# ディレクトリを移動したら ls する
add-zsh-hook precmd autols
autols(){
    [[ ${AUTOLS_DIR:-$PWD} != $PWD ]] && ls
      AUTOLS_DIR="${PWD}"
}

# lessの設定
# -i 検索wordに大文字が含まれない限りignore case
# -M ファイル名、行数、進捗を表示
# -R 色のエスケープを解釈
# -X less終了時に出力をクリアしない
# -F 1画面以内に収まるときはlessから抜ける
# -j10 現在のハイライト行を上から10行目に設定(デフォルトは1行目)
export LESS="-iMRXFj10"
alias le="less"

# lessでsyntax highlightをする
case ${OSTYPE} in
    darwin*)
        syntax_path="/usr/local/bin/src-hilite-lesspipe.sh"
        ;;
    linux*)
        syntax_path="/usr/bin/src-hilite-lesspipe.sh"
        ;;
esac
[ -e $syntax_path ] && export LESSOPEN="| $syntax_path %s"

# lsとかの設定
case ${OSTYPE} in
    linux*)
        alias ls="ls --color=auto"
        ;;
esac
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias l='ls'
alias ll='ls -l'
alias lla='ls -la'
alias grep='grep --color=auto'

# Global alias
alias -g L="| less"
alias -g G="| grep --color=auto"
alias -g W="| wc -l"
alias -g X="| xargs"
alias -g H="| head"
alias -g T="| tail"

# その他便利系
alias pg='ps aux | grep'
alias zconf='vim ~/.zshrc'
alias vconf='vim ~/.vimrc'
alias vconfb='vim ~/dotfiles/vim/init/basic.vim'
alias vconfp='vim ~/dotfiles/vim/dein/plugins.toml'
alias vconfd='vim ~/dotfiles/vim/dein/rc.vim'
alias tconf='vim ~/.tmux.conf'
alias tconfo='vim ~/dotfiles/tmux/.tmux.conf.osx'
alias tconfl='vim ~/dotfiles/tmux/.tmux.conf.linux'
alias pconf='vim ~/Library/Application\ Support/Karabiner/private.xml'
alias pconfcp='cp ~/Library/Application\ Support/Karabiner/private.xml ~/dotfiles/osx/'
alias sc='source ~/.zshrc'
alias dt='cd ~/dotfiles'
alias aconf='vim ~/.ansible.cfg'
alias ahost='vim ~/dotfiles/ansible/inventory/hosts'
alias ans='cd ~/dotfiles/ansible'

# git aliases
alias st='git status'
alias ga='git add'
alias gaa='git add -A'
alias gau='git add -u'
alias gai='git add -i'
alias gap='git add -p'
alias co='git commit -m'
alias coa='git commit --amend'
alias gk='git checkout'
alias gob='git checkout -b'
alias gb='git branch'
alias gbd='git branch -D'
alias gp='git push -u origin'
alias gpf='git push -f origin'
alias gpb='gp B'
alias gpfb='gpf B'
alias pu='git push'
alias pl='git pull'
alias gf='git fetch'
alias gt='git tree --all'
alias gth='git tree'
alias gr='git reset'
alias grh='git reset --hard'
alias gs='git stash'
alias gsp='git stash pop'
alias gd='git diff'
alias gds='git diff --stat'
alias gdc='git diff --cached'
alias gdcs='git diff --stat --cached'
alias gsh='git show'
alias gcn='git clean -n'
alias gcf='git clean -f'
alias gg='git grep -H --heading --break'
alias -g B='`git rev-parse --abbrev-ref HEAD`'

# n階層あがる
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

#tmux
tmux_new(){
    tmux new -A -n ${PWD##*/} -s $@
}
alias tn='tmux_new'
alias ta='tmux a'
alias tls='tmux ls'

# sudo vimでもvimrc反映（環境保存）
alias svim='sudo -E vim'
# alias svim='sudoedit'

# コマンド終了時に音を鳴らす
alias -g F=";echo -e '\a'"

# よく使うコマンド
alias hn='hostname'
alias hni='hostname -i'
alias setup='scp ~/dotfiles/setup.sh'
alias upd='(cd ~/dotfiles; git pull)'
alias cot='open -a /Applications/CotEditor.app'


# docker関連
alias dp='docker ps -a'
alias drma='docker rm -f $(docker ps -a -q)'
alias dim='docker images'
alias din='docker inspect'
alias dv='docker volume ls'
alias dvrm='docker volume ls -qf dangling=true | xargs -r docker volume rm'

# ansible関連
alias api='ansible-playbook -i'

# my_scripts反映
# script_dir=~/my_scripts
# fpath=(${script_dir}(N-/) $fpath)
# if [ -d $script_dir ]; then
#     for filepath in ${script_dir}/*
#     do
#         if [ -f $filepath -a -x $filepath ]; then
#             filename=${filepath##*/}
#             autoload -Uz $filename
#             $filename
#         fi
#     done
# fi

## Set path for pyenv
# export PYENV_ROOT="${HOME}/.pyenv"
# if [ -d "${PYENV_ROOT}" ]; then
#     export PATH=${PYENV_ROOT}/bin:$PATH
#     eval "$(pyenv init -)"
#     eval "$(pyenv virtualenv-init -)"
#     export PATH=$PATH:~/.pyenv/plugins/pyenv-virtualenv/shims:~/.pyenv/shims:~/.pyenv/bin
# fi

# source additional settings
if [ -e ~/.zshrc_custom ]; then
    source ~/.zshrc_custom
fi

if [ -e ~/dotfiles/zsh/.yzshrc ]; then
    source ~/dotfiles/zsh/.yzshrc
fi

# go
export GOPATH=$HOME/.go

