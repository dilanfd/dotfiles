# This is an .zshrc configuration
# Owner: Dilan Fernando <dilan.fd@gmail.com>
# Refactored on: 12/10/2017.



########## BASIC TERMINAL CONFIG ####################
export TERM="xterm-256color"
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
######### BASIC TERMINAL CONFIG END #################



################# EMACS CONFIG #############################
export VISUAL=emacsclient
export EDITOR='emacsclient --alternate-editor='
export ALTERNATE_EDITOR=""
alias emacs="open -a /Applications/emacs.app $1"
# returns the prompt w/out waiting.
alias ec="emacsclient -n" # -n stands for --no-wait. 
alias vim="emacsclient -n"
################ EMACS CONFIG END ##########################



############# Nano Config ######################
export PATH="/usr/local/opt/ncurses/bin:$PATH"
############ Nano config End ###################



################# OH MY ZSH ##################
# most functions are not used. Pure promt is used
# insted.
export ZSH=/Users/Dilan/.oh-my-zsh
# Set theme to empty for pure prompt to work
ZSH_THEME=""
############### OH MY ZSH END ################


#################### ENV VARS ###################################
# For compilers to find openSSL
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
# For pkg-config to find openSSL
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
################### ENV VAR END ################################



###################### PURE PROMPT CONFIG #####################
# configuration for the minimalistic pure prompt.
# oh-my-zsh themes are diabled but other oh-my-zsh goodies
# still work. (such as tab completion of git commands etc.)
autoload -Uz promptinit
promptinit
prompt pure

# colored completion - use my LS_COLORS
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
################### PURE PROMPT CONFIG END ######################



############## ANACONDA ##########################
export PATH=~/anaconda/bin:/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/bin:$PATH
############# ANACONDA END ########################



############### GIT COMPLETIONS FOR ZSH ##########
plugins=(git zsh-completions osx)
autoload -U compinit && compinit
fpath=(/usr/local/share/zsh-completions $fpath)
############### GIT COMPLETIONS END #############



############## MS AZURE KEYS ########################
export AZURE_STORAGE_ACCESS_KEY="LvdxYlkRLFWSt8NDS73NN46JCGrgROM72QywVci3PpAvSxIF5koLHS/SV9Oj/wil32UBEGUH0mZxpiwHXF8tGA=="
export AZURE_STORAGE_ACCOUNT="adsautoscrub"
############## AS AZURE KEYS END #########################



##################### ALIASES BEGIN ########################
# Set personal aliases, overriding those provided by oh-my-zsh libs,
alias ls="ls -GpFh"
#alias rm="rmtrash"
alias matlab='/Applications/MATLAB_R2016b.app/bin/matlab -nodesktop'
# jupyter notebook alias
alias jn="jupyter notebook"
###################### ALIASES END ##############################



################### EXPORT PATH ##############################
export PATH="/usr/local/opt/freetds@0.91/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/freetds@0.91/bin:$PATH"
export PATH=$PATH:/Users/Dilan/bin
export PATH="/usr/local/opt/libxml2/bin:$PATH"
######### EXPORT PATH END ####################################



################# AZURE COMMAND COMPLETIONS #################
# this line makes sure azure auto complte works as intended on zsh as well
autoload bashcompinit && bashcompinit
# source az.completion.sh # runs everytime .zshrc is sourced if enabled.
# source '/Users/Dilan/lib/azure-cli/az.completion'
# . <(azure --completion)
# . <(azure --completion)
# function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
. <(azure --completion)
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
################# AZURE COMMAND COMPLETIONS ################



################### R STUDIO and R ######################
# make sure R-studio sees the homebrew installed latest R
export RSTUDIO_WHICH_R=/usr/local/bin/R
################### R STUDIO and R END ##################



#################### CS 50 CLASS ##########################
# CS 50 make file custom command.
function make50 { clang -ggdb3 -Wall -Werror "$1".c -o "$1" -I /usr/local/include -L /usr/local/lib -lcs50; }
################### CS 50 END #############################



############### Add RVM to PATH for scripting ###############
# IMPORTANT: Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
############### RVM PATH ###################################



############## CONFIG to track dot files effectively
alias config='/usr/local/bin/git --git-dir=/Users/Dilan/.myconfig/ --work-tree=/Users/Dilan'
############# Config tracking alias end



################# SYNTAX HIGHLIGHTING for ZSH ##################### 
# THIS MUST BE the last line
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
################ SYNTAX HIGHLIGHTING FOR ZSH END ##################
