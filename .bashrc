echo "start of ~/.bashrc"
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

## if [ "$color_prompt" = yes ]; then
##     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
## else
##     #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
##     PS1='${debian_chroot:+($debian_chroot)}[\u@\h:\W]$ '
## fi
## unset color_prompt force_color_prompt

## # If this is an xterm set the title to user@host:dir
## case "$TERM" in
## xterm*|rxvt*)
##     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
##     ;;
## *)
##     ;;
## esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    #export LS_COLORS='ex=91:di=33:ln=90;1'
    export LS_COLORS='ex=91:di=34:ln=90;1'
else
    #alias ls='ls -F --color=auto'
    alias ls='ls -F '
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
    export LS_COLORS='ex=91:di=33:ln=90;1'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
#alias adb='sudo /home/jc/bin/adb'
#alias fastboot='sudo /home/jc/bin/fastboot'
#alias cs='if [ -s cscope.out ]; then echo -ne "\033]0;cscope    ---    $(basename $(pwd)) \007"; cscope -C -d csope.out ; else cscope -C -i cscope.files; fi'
alias cs='if [ -s cscope.out ]; then echo -ne "\033]0;cscope    ---    $(pwd) \007"; cscope -C -d csope.out ; else cscope -C -i cscope.files; fi'
alias jmaguro='cd ~/space/work/android/maguro'
alias jc_date='date +"%m%d-%I%M"'
alias setup_maguro='source build/envsetup.sh && lunch full_maguro-userdebug && source ~/bin/setup_linux_cross_compile.sh'
alias setup_panda='source build/envsetup.sh && lunch full_panda-userdebug && source ~/bin/setup_linux_cross_compile.sh'
alias setup_mako='source build/envsetup.sh && lunch full_mako-userdebug && source ~/bin/setup_linux_cross_compile.sh'
alias setup_hammerhead='source build/envsetup.sh && lunch aosp_hammerhead-userdebug && source ~/bin/setup_linux_cross_compile.sh'

alias run="cmd \\\/c "

alias pfunc='perldoc -f'
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias int_perl='perl -d -e42'
export PAGER='less -Xisr'
export GREP_OPTIONS=' --directories=skip '
#export PS1="[\W]$ "
#export VISUAL=gvim
export VISUAL='gvim.bat -f'
#export CSCOPE_EDITOR=gvim.bat
#export CSCOPE_EDITOR=gvim.bat
export CSCOPE_EDITOR=cscope-edx.sh
export CS_NUM=1
export JAVA_HOME=/c/Java/jdk1.6.0_45
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:/c/MinGW/bin:/c/MinGw/msys/1.0/bin
export LESS="-Xisr"
alias cs_ed_def='export CSCOPE_EDITOR=gvim.bat'
alias cs_ed='export CSCOPE_EDITOR=cscope-ed.sh'
alias cs_ed1='export CSCOPE_EDITOR=cscope-ed.sh'
alias cs_ed2='export CSCOPE_EDITOR=cscope-ed2.sh'

#gvim() { setsid /usr/bin/gvim -f "$@";}

export GIT_EDITOR='gvim -f'
#alias gvim="start /c/vim/vim74/gvim.exe "
#alias gvim="cmd \\\/c /c/vim/vim74/gvim"
#alias gvim="cmd \\\/c /c/Users/hrkv84-sc/bin/gvim.bat"
alias gvim="cmd \\\/c gvim.bat"

function dec2hex { echo "$*" |bc ~/bin/bc.dec2hex; }
function hex2dec { echo "$*"|tr '[a-z]' '[A-Z]' |bc ~/bin/bc.hex2dec; }
function hex2bin { echo "$*"|tr '[a-z]' '[A-Z]' |bc ~/bin/bc.hex2bin;}

## function diff_all { for i in $(git status |awk '/modified/{print $3}'|sed '/\.[ch]/!d') 
##     do 
##         git difftool -y $i
##     done 
## }


## function to do a diff of all .[ch] files in git
function diff_all () 
{ 
    ## set base command
    CMD="git difftool -y "
    NO_COUNT=""

    ## parse parameters
    if [ $# -gt 0 ]; then
        for i in $*; do
            case "$i" in 
                -l) CMD="echo "
                    NO_COUNT=1
                    ;;
                -h) echo "options are: -[hl]"
                    return 1
                    ;;
            esac
        done
    fi

    ## populate an array with the git files
    array=($(git status |awk '/modified/{print $3}'|sed '/\.[ch]/!d'))
    count=1

    ## iterate over the array 
    for i in ${array[*]};
    do
        if [ -z $NO_COUNT ]; then
            echo file $((count++)) of ${#array[*]}: $i  
        fi
        $CMD $i
    done
}

function pull_wav ()
{
    mplayer -benchmark -vc null -vo null -ao pcm:waveheader $*
}

alias clt=cleartool
alias xdiff=xdiff.bat

source ~/bin/jc_bash_functions.sh
export TMPDIR=c:/Temp
export CYGWIN=nodosfilewarning

echo "end of ~/.bashrc"
