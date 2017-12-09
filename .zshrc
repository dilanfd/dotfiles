export TERM="xterm-256color"
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
#export LSCOLORS=GxFxCxDxBxegedabagaced
#added this line to test git commits
# colored completion - use my LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# If you come from bash you might have to change your $PATH.
# export PATH="/Users/Dilan/anaconda/bin:$PATH"
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# emacs recommends changing path in .zshenv rather than in .zshrc. So the above
# lines have been commented out and replaced in .zshenv.
export VISUAL=emacsclient
export EDITOR='emacsclient --alternate-editor='
export ALTERNATE_EDITOR=""
alias emacs="open -a /Applications/emacs.app $1"
# alias emacs='/usr/local/bin/emacs --no-wait'
alias ec="emacsclient -n" # -n stands for --no-wait. returns the prompt w/out waiting.
alias vim="emacsclient -n"

# export PATH="$HOME/anaconda/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$PATH"
#
# lines uncommented again bc otherwise system ends up using the apple python rather than
# anaconda python.
export PATH=~/anaconda/bin:/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/bin:$PATH

export ZSH=/Users/Dilan/.oh-my-zsh
# access man pages for gnu utilities with usual names.
# MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# some stuff to see if diff works
########### EXTREMELY IMPORTANT ENV VARS #######
# For compilers to find openSSL
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
# For pkg-config to find openSSL
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

# For uwsgi to work.


# ZSH_THEME="agnoster"
ZSH_THEME=""

# configuration for the minimalistic pure prompt.
# oh-my-zsh themes are diabled but other oh-my-zsh goodies
# still work. (such as tab completion of git commands etc.)

autoload -Uz promptinit
promptinit
prompt pure

# autoload -U promptinit; promptinit
# prompt pure

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

plugins=(git zsh-completions osx)
autoload -U compinit && compinit
fpath=(/usr/local/share/zsh-completions $fpath)
# enabling the following messes up the pure prompt !!! Aaaargh !!!!
# source $ZSH/oh-my-zsh.sh # this line is neede for git completions to work.


# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
# User configuration
############## MS AZURE stuff for ADS LLC ########################
export AZURE_STORAGE_ACCESS_KEY="LvdxYlkRLFWSt8NDS73NN46JCGrgROM72QywVci3PpAvSxIF5koLHS/SV9Oj/wil32UBEGUH0mZxpiwHXF8tGA=="
export AZURE_STORAGE_ACCOUNT="adsautoscrub"

#################### git aliases from dan ###############

# alias lg1='git log --graph --abbrev-commit --decorate --date=relative --format=format:'\''%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'\'' --all'

# alias lg2='git log --graph --abbrev-commit --decorate --format=format:'\''%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n'\'''\''%C(white)%s%C(reset) %C(dim white)- %an%C(reset)'\'' --all'


##################### Azure stuff for ADS LLC end #################



# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# alias for colorizing the ls output and making other changes.
# -G adds color. -p adds slash after each dir
# -F puts an * after executables, | after pipes, @ after symlinks, et cetera
# -h puts will format sizes in "human readable" units, i.e. 100b 10k, 23m, 4.2g
alias ls="ls -GpFh"
#alias rm="rmtrash"
# alias emacs='open -a /Applications/Emacs.app $1'
# alias emacs='/Applications/Emacs.app $1'
# alias emacs='/usr/local/cellar/emacs/25.1/emacs.app/contents/macos/emacs'
alias matlab='/Applications/MATLAB_R2016b.app/bin/matlab -nodesktop'
# alias ads='source ~/ADSLLC/ads3/bin/activate'
# alias thesis='source activate thesisPy36'
#exporting anaconda path to open jupyter notebook from zsh terminal.
# export PATH="/Users/Dilan/anaconda/bin:$PATH"

# Vi mode
# bindkey -v

#kill the lag time between changing modes
# export KEYTIMEOUT=2
# this seems to break the jj key mapping below.

# hitting jj goes into command mode. just like in vim.
bindkey -M viins 'jj' vi-cmd-mode

#adding an alias for jupyter notebook
alias jn="jupyter notebook"
# source activate py35

# this line makes sure azure auto complte works as intended on zsh as well
autoload bashcompinit && bashcompinit
# source az.completion.sh # runs everytime .zshrc is sourced if enabled.
export PATH="/usr/local/opt/freetds@0.91/bin:$PATH"

export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/freetds@0.91/bin:$PATH"
export PATH=$PATH:/Users/Dilan/bin
. <(azure --completion)
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# make sure R-studio sees the homebrew installed latest R
export RSTUDIO_WHICH_R=/usr/local/bin/R

export PATH="/usr/local/opt/libxml2/bin:$PATH"

# CS 50 make file custom command.
function make50 { clang -ggdb3 -Wall -Werror "$1".c -o "$1" -I /usr/local/include -L /usr/local/lib -lcs50; }
# CS 50 customa make end.

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# the following line must be the last line.
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source '/Users/Dilan/lib/azure-cli/az.completion'
# . <(azure --completion)
# . <(azure --completion)
# function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}


alias config='/usr/local/bin/git --git-dir=/Users/Dilan/.myconfig/ --work-tree=/Users/Dilan'
