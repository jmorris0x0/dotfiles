######### Source ###########################
# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc

######## Load tmux #########################
if [ -x "$(command -v tmux)" ] && \
   [ -n "$PS1" ] && \
   [[ ! "$TERM" =~ screen ]] && \
   [[ ! "$TERM" =~ tmux ]] && \
   [ -z "$TMUX" ]; then
  exec tmux -v
fi

######### Load system specific stuff #######
OS="$(uname -s)"
if test "$OS" = "Darwin"; then
    ######## For broken xvfb ###################
    export EVENT_NOKQUEUE=1
    ######## Rasperrry pi dev
    alias pi='ssh pi@raspberrypi.local'
    ######### Architecture Flags ###############
    export ARCHFLAGS="-arch x86_64"

    ######## For Homebrew ######################
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

    ############## ALIASES:######################
    alias top='top -s3 -o cpu -R -F'

    alias connect="lein repl :connect localhost:7888"

    alias project=". project"
    alias localip="ipconfig getifaddr en0"
    ####### Generic Colorizer ##################
    # For diff, etc.
    source "`brew --prefix`/etc/grc.bashrc"

    export DOCKER_HOST=unix:///var/run/docker.sock

    # This is so that docker instance can reach localhost postgresql. Not sure why I addeed thing above.
    export DOCKERHOST="$(ifconfig en0 inet | grep "inet " | awk -F'[: ]+' '{ print $2 }')"

    function dockbash() { docker exec -it $@ bash; }
    function dockbashroot() { docker exec -u root -it $@ bash; }

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
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias l="ls"
alias sl="ls"
alias cd..='cd ..'
alias vim='nvim'
alias tf='terraform'
alias k='kubectl'

###### Always use color output for `ls` #########
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

alias ls="command ls ${colorflag}"

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

############ PYTHON STUFF ##################
export CONDA_DEFAULT_ENV="py36"

if [ -d "${HOME}/anaconda3" ]; then
    # export PATH="${HOME}/anaconda/bin:$PATH"
    # Use for python 3.5:
    export PATH="${HOME}/anaconda3/envs/${CONDA_DEFAULT_ENV}/bin:${HOME}/anaconda3/bin:${PATH}"
    # To create and environment:
    # conda update conda
    # conda create -n py35 python=3.5 anaconda
    # To activate this environment, use:
    source activate $CONDA_DEFAULT_ENV &>/dev/null
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
    :
    # python --version
fi

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

######### For comprehensive shell logs #########
# Create history logging folder if does not exist
mkdir -p $HOME/.logs

history_log() {
  if [ "$(id -u)" -ne 0 ];
    then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log;
    fi
}

function searchlogs() { grep -H  "$@" ~/.logs/*.log; }

# Might want to try this as well:
# http://www.pointsoftware.ch/howto-bash-audit-command-logger/
# https://debian-administration.org/article/543/Bash_eternal_history

# Write a copy of time-stamped history to a daily log file.
PROMPT_COMMAND=history_log

######## For AWS ##########################
function whichaws {
    caller=$(aws sts get-caller-identity)
    alias=$(aws iam list-account-aliases --query AccountAliases[0] --output text)
    region=$(aws configure get region)

    account=$(echo $caller | jq -r '.Account')
    echo "Account: $account"
    echo "Alias:   $alias"

    UserId=$(echo $caller | jq -r '.UserId')
    echo "UserId:  $UserId"

    UserARN=$(echo $caller | jq -r '.Arn')
    echo "UserArn: $UserARN"

    echo "Region:  $region"
}

function aws_prompt {
    if [ -n "$AWS_ACCESS_KEY_ID" ] && [ -x "$(command -v aws)" ]; then
        if [ -z "$LAST_AWS_ACCESS_KEY_ID" ] || \
            [ "$LAST_AWS_SECRET_ACCESS_KEY" != "$AWS_SECRET_ACCESS_KEY" ] || \
            [ "$LAST_AWS_ACCESS_KEY_ID" != "$AWS_ACCESS_KEY_ID" ]; then
            export LAST_AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
            export LAST_AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
            current=$(aws iam list-account-aliases --query AccountAliases[0] --output text)
            if [ "$current" == "None" ]; then
                current=$(aws sts get-caller-identity | jq -r '.Account')
            fi
            export CURRENT_AWS_ACCOUNT_ALIAS=$current
        fi
         echo -en "\033[0;35m<$CURRENT_AWS_ACCOUNT_ALIAS>"
    fi
}

# export "PROMPT_COMMAND=$PROMPT_COMMAND;aws_prompt"

######### Added for Git ####################
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

PS1=''

if [[ $- == *i* ]]; then
    source ~/.git-prompt.sh
    source ~/.git-completion.bash
    GIT_PS1_SHOWDIRTYSTATE=true
    PS1=$PS1'$(
        if [[ $(__git_ps1) =~ \*\)$ ]]
              # a file has been modified but not added
              then echo "'$RED'"$(__git_ps1 "<%s:$(git-unpushed)>")
        elif [[ $(__git_ps1) =~ \+\)$ ]]
              # a file has been added, but not commited
              then echo "'$BROWN'"$(__git_ps1 "<%s:$(git-unpushed)>")
              # the state is clean, changes are commited
        else echo "'$GREEN'"$(__git_ps1 "<%s:$(git-unpushed)>")
        fi)'$LIGHT_GRAY"\w "
    export PS1
fi

#         fi)'$LIGHT_GRAY"\w\342\232\241 "

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
# Enable syntax-highlighting in less.
# brew install source-highlight
# First, add these two lines to ~/.bashrc
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
alias less='less -m -g -i --underline-special --SILENT'
alias more='less'

###### Xterm title ###########################
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

###### THIS STUFF SHOULD BE LAST   ############
# Switch your environment for AWS:
. $HOME/.aws/source-me.sh

# Stuff in my bin folder is always first
export PATH="${HOME}/bin:${PATH}"

export KUBERNETES_PROVIDER='aws'

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# added by Anaconda3 4.2.0 installer
export PATH="/Users/jonathan/anaconda3/bin:$PATH"

cd $HOME/code

eval "$(direnv hook bash)"

export GITHUB_TOKEN=''
                                        
function parkside() {
    if [[ $@ == "update" ]]; then
        command docker pull quay.io/parkside-securities/parkside-cli
    else
        command docker run -e "GITHUB_TOKEN=${GITHUB_TOKEN}" quay.io/parkside-securities/parkside-cli:latest "$@"
    fi
}

# For gnu internet utilities. They are prepended with 'g' but this will fix that:
# If these are missing, install with 'brew install coreutils'
PATH="/usr/local/opt/inetutils/libexec/gnubin:$PATH"

source ~/.iterm2_shell_integration.bash

# For K8s
source <(kubectl completion bash | sed s/kubectl/k/g)

