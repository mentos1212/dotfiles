#encode
export LANG=ja_JP.UTF-8
export LESSCHARSET=UTF-8

#executable
umask 022

#bash aliases
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ll='ls -la'
alias grep='grep --color=auto'
alias p='pushd .'
alias pp='popd'

#history
HISTSIZE=50000
HISTFILESIZE=100000

# Find top 5 big files
alias big5="find . -type f -exec ls -s {} \; | sort -n -r | head -5"

# To navigate to the different directories
alias ..='cd ..'
alias ...='cd ../..'

alias vim='/usr/bin/vim'

#dotfiles dir
DOTFILES_ROOT=~/Development/dotfiles

if [ `uname` = "Darwin" ]; then
    source $DOTFILES_ROOT/bashrc.Darwin
elif [ `uname` = "Linux" ]; then
    source $DOTFILES_ROOT/bashrc.ubuntu
fi

if [ -e ~/.bashrc.custom ]; then
    source ~/.bashrc.custom
fi

#ssh alias
alias magicc="ssh magicc"
alias magicm="ssh magicm"

alias wired="ssh -A wired"
alias wiredc="ssh -A cyber@wired.cyber.t.u-tokyo.ac.jp -p 54322"
#alias mansei="ssh -A -L 13306:localhost:3306 manseibashi@wired.cyber.t.u-tokyo.ac.jp -p 54322 -i ~/.ssh/manseibashi_rsa"

alias aria="ssh -A -L 54322:aria.cyber.t.u-tokyo.ac.jp:22 cyber@wired.cyber.t.u-tokyo.ac.jp -p 54322 -i ~/.ssh/id_dsa_cyber_new"

alias upmain="/Users/mentos/lab/Mansei/upload_to_server.sh"
alias matlab="ssh -L 27000:wired:27000 -L 27005:wired:27005 wired.cyber.t.u-tokyo.ac.jp -l m_okada -p 54322"

#alias camera="/Users/mentos/.ssh/camera.sh"
alias camera="/Users/mentos/.ssh/camera2.sh"
alias killcam="pgrep -f 'guri.cyber' | xargs kill"
alias openc="/Users/mentos/.ssh/opencamera.sh"


#itermのタブ名にカレントディレクトリを表示させる
PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
defaults write com.googlecode.iterm2 OptimumTabWidth -int 2000
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
### Add current directory to PYTHONPATH
export PYTHONPATH=.:$PYTHONPATH

#mysql util
alias startsql='mysql.server start'

#goodriver server db connect
alias delosql='ssh -fN delosql'

#syuron util
alias syuron='cd /Users/mentos/lab/LifeLog/mthesis_okada'

#localog util
alias adt='/Users/mentos/lab/LifeLog/programs/localog/databases/db_transfer.sh'
alias localog='cd /Users/mentos/lab/LifeLog/programs/Goodriver'
alias delorean='cd /Users/mentos/lab/LifeLog/programs/delorean'
alias delo='ssh delorean'
alias goodriver='cd /Users/mentos/lab/Lifelog/programs/goodriver-server'
alias ms='mysql.server'

#git util
alias st='git status'
alias ga='git add'
alias co='git commit'
alias gc='git checkout'
alias pu='git push'
alias pl='git pull'
alias gt='git tree'




