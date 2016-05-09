#alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
#alias eopen='open -a "Emacs.app"'
alias emacs='/usr/local/Cellar/emacs/HEAD/Emacs.app/Contents/MacOS/Emacs -nw'
alias eopen='open -a "/usr/local/Cellar/emacs/HEAD/Emacs.app"'
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

function ssh_complete() {
local curw
local hosts=()
COMPREPLY=()
curw=${COMP_WORDS[COMP_CWORD]}
ORIG=$IFS
IFS="
"
if [ -f "$HOME/.ssh/known_hosts" ]; then
  hosts=(${hosts[@]} $(cut -f 1 -d " " $HOME/.ssh/known_hosts))
fi
if [ -f "$HOME/.ssh/config" ]; then
  hosts=(${hosts[@]} $(grep '^Host ' "$HOME/.ssh/config" | cut -f 2 -d ' '))
fi
COMPREPLY=($(compgen -W '${hosts[@]}' -- $curw))
IFS=$ORIG
return 0
}
complete -F ssh_complete ssh

export PATH=$PATH:/Applications/android-sdk-macosx/platform-tools
export PATH=$PATH:/Applications/android-sdk-macosx/tools
export PATH="$PATH:/Users/mentos/android-sdks/platform-tools:/Users/mentos/android-sdks/tools"
export NODE_PATH=/usr/local/lib/node_modules:/Users/mentos/.nvm/v0.11.14/lib/node_modules
unset LD_LIBRARY_PATH
unset DYLD_LIBRARY_PATH

source ~/.bashrc

if [[ -s ~/.nvm/nvm.sh ]];
	then source ~/.nvm/nvm.sh
fi
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
