######### Source ###########################
# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc
######### project switching functions ######
function legacy {
    export PROJECT_DIR="/home/scraper"
    cd $PROJECT_DIR
    if grep -Fxq "legacy" $HOME/.current-project
    then
        echo "Already on project: legacy"
    else
        echo "Switching project to: legacy"
        mv $HOME/.aws_bak $HOME/.aws
        rm $HOME/.current-project
        echo "legacy" > $HOME/.current-project
    fi
}

function rev2 {
    export PROJECT_DIR="$HOME/code/revcaster-shopper"
    cd $PROJECT_DIR
    if grep -Fxq "rev2" $HOME/.current-project 
    then
        echo "Already on project: rev2"
    else
        echo "Switching to project: rev2"
        mv $HOME/.aws $HOME/.aws_bak
        rm $HOME/.current-project
        echo "rev2" > $HOME/.current-project
    fi
}

######### Load system specific stuff #######
OS="$(uname -s)"
if test "$OS" = "Darwin"; then

    ######### Architecture Flags ###############
    export ARCHFLAGS="-arch x86_64"

    ######## For Homebrew ######################
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

    ############## ALIASES:######################
    alias top='top -s3 -o cpu -R -F'
    alias neva='ssh nevawood@Neva.local'
    alias data='ssh jonathan@dataserve.local'
    alias instance='ssh -i "cascadekey2.pem" root@ec2-54-177-126-187.us-west-1.compute.amazonaws.com'
    #alias xvfb-run='Xvfb :1337 & export DISPLAY=:1337 &'
    alias xvfb-run='Xvfb &'
    #alias matlab='/Applications/MATLAB_R2012b.app/bin/matlab -nojvm, -nodesktop, -nosplash'
    # Show/hide hidden files in Finder
    alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
    alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"    

    alias legacy="legacy"
    alias rev2="rev2"    
    # alias localip="ipconfig getifaddr en0"
    # alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

    ####### RevCaster Stuff ####################
    export SLIMERJSLAUNCHER=/Applications/Firefox.app/Contents/MacOS/firefox

   ###### Connect to docker instance ############
   # http://stackoverflow.com/questions/32744780/install-docker-toolbox-on-a-mac-via-command-line
    if [ -x "$(command -v docker-machine)" ]; then
        eval "$(docker-machine env defaultBox)"
    fi

elif test "$OS" = "Linux"; then
    :

    ##### Linux specfic Aliases ##################
    # nothing here for now.
fi

##### Non-system specfic Aliases #################
alias badge="tput bel"
alias hidden='ls -d .*'
alias ls='ls -FA' 
alias exit='jobs; exit'
alias lsgit='git ls-tree master --name-only '
alias pull='git pull -s recursive -X theirs'
# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias l="ls"
alias sl="ls"
alias scrapers3="cd $HOME && rm -fr $HOME/deploy-old > /dev/null && mv $HOME/deploy $HOME/deploy-old > /dev/null && mkdir $HOME/deploy && cd $HOME/deploy && aws --profile Rev2 s3 cp s3://revcaster.develop.deployment-artifacts/revcaster-php-shopper/deploy.zip $HOME/deploy/deploy.zip --region us-west-2 && unzip $HOME/deploy/deploy.zip"

alias deploy="cd /home && rm -fr /home/deploy-old > /dev/null && mv /home/deploy /home/deploy-old > /dev/null && mkdir /home/deploy && cd /home/deploy && aws --profile Rev2 s3 cp s3://revcaster.develop.deployment-artifacts/revcaster-php-shopper/deploy.zip /home/deploy/deploy.zip --region us-west-2 && unzip /home/deploy/deploy.zip"

###### Always use color output for `ls` #########
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

alias ls="command ls ${colorflag}"

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

########### GOLANG ##############################
if [ -x "$(command -v go)" ]; then
    export GOPATH=$HOME/code/go
    export PATH=$PATH:$GOPATH/bin
    export PATH=$PATH:/usr/local/opt/go/libexec/bin
fi

############ PYTHON STUFF ##################
# uncomment below if using homebrew python
# export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

# For installation of anaconda I used:
# http://www.uni-bonn.de/~hmg308/teaching/prog_econ/2013/installation_guide/index.html
############ Anaconda #######################
if [ -d "${HOME}/anaconda" ]; then
    # export PATH="${HOME}/anaconda/bin:$PATH"
    # Use for python 3.5:
    export PATH="${HOME}/anaconda/envs/py34/bin:${HOME}/anaconda/bin:${PATH}"
    # To create and environment:
    # conda update conda
    # conda create -n py35 python=3.5 anaconda
    # To activate this environment, use:
    source activate py34 &>/dev/null
    #
    # To deactivate this environment, use:
    # $ source deactivate

    # To install stuff:
    # conda install -n py33 statsmodels
    # or
    # pip install coverage

    # conda info
elif [ -x "$(command -v brew)" ]; then
    export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
fi

if [[ $- == *i* ]]
  then
    python --version
fi

### For the Heroku Toolbelt ###########
if [ -d "/usr/local/heroku" ]; then
    export PATH="/usr/local/heroku/bin:$PATH"
    export PATH=$PATH:/usr/x11/bin
fi

### Added for phpbrew ######################
if [ -d "${HOME}/.phpbrew" ]; then
    source $HOME/.phpbrew/bashrc
    export PHPBREW_SET_PROMPT=0
    PHP_VERSION=$(phpbrew_current_php_version)
    if [[ $- == *i* ]]; then
        echo $PHP_VERSION
    fi
    #phpbrew lookup-prefix homebrew
elif [ -x "$(command -v brew)" ]; then 
    # export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"
    php --version
fi

####### PerlBrew ###########################
if [ -d "${HOME}/perl5" ]; then
    source ~/perl5/perlbrew/etc/bashrc
fi
####### For Haskell #########################
# export PATH="/Users/jonathan/.local/bin:$PATH"

######## Fancy Terminal Colors ##############
MAGENTA="\[\033[0;35m\]"
LIGHT_MAGENTA="\[\033[1;35m\]"
YELLOW="\[\033[1;33m\]"
BLUE="\[\033[0;34m\]"
LIGHT_BLUE="\[\033[1;34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
WHITE="\[\033[1;37m\]"
CYAN="\[\033[0;36m\]"
LIGHT_CYAN="\[\033[1;36m\]"
GREEN="\[\033[0;32m\]"
BROWN="\[\033[0;33m\]"
RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
DARK_GRAY="\[\033[1;30m\]"
LIGHT_GREEN="\[\033[1;32m\]"
ORANGE="\[\033[1;40m\]"

###### Shell colors #########################
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

###### Environmental variables #############
export EDITOR=vim

###### For timing Bash commands ############
# BCT_AT_PROMPT=1
# function BCTPreCommand() {
#   if [ -z "$BCT_AT_PROMPT" ]; then
#     return
#   fi
#   unset BCT_AT_PROMPT
#   BCT_COMMAND_START_TIME=$(eval $BCTTime)
# }
# trap 'BCTPreCommand' DEBUG



# timer_stop() {
#   timer_show= $(($SECONDS - $timer))
#   unset timer
#   echo "timer_stop"
#   # echo $timer_show
# }

# trap '$(timer_start)' DEBUG

####### History stuff #######################
# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# The following is from:
# http://askubuntu.com/questions/312444/how-to-make-the-command-line-history-apply-across-all-terminals
# Keeps history synced between all open terminals
HISTSIZE=10000
HISTFILESIZE=$HISTSIZE
HISTTIMEFORMAT="%d/%m/%y %T "

history() {
  _bash_history_sync
  builtin history "$@"
}

_bash_history_sync() {
  builtin history -a
  HISTFILESIZE=$HISTSIZE
  builtin history -c
  builtin history -r
}

# Create history loggin folder if does not exist
mkdir -p $HOME/.logs

history_log() {
  if [ "$(id -u)" -ne 0 ];
    then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log;
    fi
}
# MIght want to try this as well:
# http://www.pointsoftware.ch/howto-bash-audit-command-logger/
# https://debian-administration.org/article/543/Bash_eternal_history

# Write a copy of time-stamped history to a daily log file.
PROMPT_COMMAND=history_log
# PROMPT_COMMAND='timer_stop'
#timer_stop

######### Added for Git ####################
alias gitupdate='echo "fetch...rebase...push" && git fetch upstream && git rebase upstream/master && git push -f origin master'
# export PS1='[\w$(__git_ps1)]\$ '
#parse_git_branch() {
# git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }
#export PS1="($CONDA_DEFAULT_ENV)\w\[\033[32m\]\$(parse_git_branch)\[\033[00m\]$ "

function git-branch-name {
    echo $(git rev-parse --abbrev-ref HEAD 2>/dev/null)
}

function git-unpushed {
    if [ -d .git ]; then
        brinfo=$(git branch -v | grep -F -f <(git-branch-name))
        if [[ $brinfo =~ ("[ahead "([[:digit:]]*)]) ]]
        then
            echo "(${BASH_REMATCH[2]})"
        fi
    fi
}

#PS1=$(whoami)
PS1=''

if [[ $- == *i* ]]; then
    source ~/.git-prompt.sh
    source ~/.git-completion.bash
    GIT_PS1_SHOWDIRTYSTATE=true
    if [ -d "${HOME}/anaconda" ]; then
        PS1=$PS1$LIGHT_BLUE"<$CONDA_DEFAULT_ENV> "
    else 
        PS1=$PS1''
    fi

    PS1=$PS1'$(
        if [[ $(__git_ps1) =~ \*\)$ ]]
              # a file has been modified but not added
              then echo "'$RED'"$(__git_ps1 "<%s:$(git-unpushed)>")
        elif [[ $(__git_ps1) =~ \+\)$ ]]
              # a file has been added, but not commited
              then echo "'$BROWN'"$(__git_ps1 "<%s:$(git-unpushed)>")
              # the state is clean, changes are commited
        else echo "'$GREEN'"$(__git_ps1 "<%s:$(git-unpushed)>")
        fi)'$LIGHT_GRAY" \w\[\342\232\241\e[m\] "
    export PS1
fi
        # fi)'$LIGHT_GRAY" \w  ["'$timer_show'" s] \342\232\241 "
######## For AWS and Oanda #################
test -f $HOME/.credentials && source $HOME/.credentials

###### shopt stuff #########################
# append to the history file, don't overwrite it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

####### less config ##########################
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

###### Xterm title ###########################
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
###### THIS SHOULD BE LAST   #################
#
# Stuff in my bin folder is always first
#
export PATH="${HOME}/bin:${PATH}"

####### For Revcaster ######################
cd $PROJECT_DIR


# added by Anaconda3 2.5.0 installer
# export PATH="//anaconda/bin:$PATH"

# added by Anaconda3 2.5.0 installer
# export PATH="/Users/jonathan/anaconda/bin:$PATH"

export KUBERNETES_PROVIDER='aws'
