######### Source ###########################
# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc

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
    #alias xvfb-run='Xvfb :1337 & export DISPLAY=:1337 &'
    alias xvfb-run='Xvfb &'
    #alias matlab='/Applications/MATLAB_R2012b.app/bin/matlab -nojvm, -nodesktop, -nosplash'
    # Show/hide hidden files in Finder
    alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
    alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"    
    
    # alias localip="ipconfig getifaddr en0"
    # alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

    ####### RevCaster Stuff ####################
    export SLIMERJSLAUNCHER=/Applications/Firefox.app/Contents/MacOS/firefox

elif test "$OS" = "Linux"; then
    continue

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
    # was added by Anaconda 1.8.0 installer. Use for python 2.7
    # export PATH="${HOME}/anaconda/bin:$PATH"

    # Use for python 3.3:
    export PATH="${HOME}/anaconda/envs/py34/bin:${HOME}/anaconda/bin:${PATH}"

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
fi

####### PerlBrew ###########################
if [ -d "${HOME}/perl5" ]; then
    source ~/perl5/perlbrew/etc/bashrc
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

###### Shell colors #########################
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

###### Environmental variables #############
export EDITOR=vim

######### Added for Git ####################
alias gitupdate='echo "fetch...rebase...push" && git fetch upstream && git rebase upstream/master && git push -f origin master'
# export PS1='[\w$(__git_ps1)]\$ '
#parse_git_branch() {
# git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }
#export PS1="($CONDA_DEFAULT_ENV)\w\[\033[32m\]\$(parse_git_branch)\[\033[00m\]$ "

if [[ $- == *i* ]]; then
    source ~/.git-prompt.sh
    source ~/.git-completion.bash
    GIT_PS1_SHOWDIRTYSTATE=true
    export PS1=$LIGHT_GRAY"($CONDA_DEFAULT_ENV)"'$(
        if [[ $(__git_ps1) =~ \*\)$ ]]
         		# a file has been modified but not added
    	      then echo "'$YELLOW'"$(__git_ps1 " (%s)")
        elif [[ $(__git_ps1) =~ \+\)$ ]]
            # a file has been added, but not commited
    	      then echo "'$MAGENTA'"$(__git_ps1 " (%s)")
    	      # the state is clean, changes are commited
    	      else echo "'$CYAN'"$(__git_ps1 " (%s)")
    	    fi)'$LIGHT_GRAY" \w"$LIGHT_GRAY"$ "
fi

######## For AWS and Oanda #################
source $HOME/.credentials

############################################
###### THIS MUST BE LAST   #################
#
# Stuff in my bin folder is always first
#
export PATH="${HOME}/bin:${PATH}"

####### For Revcaster ######################
cd /home/scraper

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;