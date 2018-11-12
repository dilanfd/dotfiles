export CLICOLOR=1
export PATH="$HOME/anaconda/bin:/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/bin:$PATH"

export PATH=$PATH:/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin
# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave




# added by Anaconda3 4.4.0 installer
export PATH="/Users/Dilan/anaconda3/bin:$PATH"

# added by Anaconda3 4.4.0 installer
export PATH="/Users/Dilan/anaconda/bin:$PATH"
# Enable tab completion
source ~/my-code/shellScripts/git-completion.bash

# colors!
green="\[\033[0;32m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
reset="\[\033[0m\]"

# Change command prompt
source ~/my-code/shellScripts/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$purple\u$green\$(__git_ps1)$blue \W $ $reset"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
