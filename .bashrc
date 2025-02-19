# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color|screen) color_prompt=yes;;
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -l'
alias lt='ls -ltr'
alias ..='cd ..'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias rt="screen -r"

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


export PAGER=less
export PATH=$HOME/.local/bin:$PATH

export EDITOR=vi

if [ -e /usr/bin/gvim ]; then
    alias vi=gvim
fi

REALPWD=$(dirname $(realpath ${BASH_SOURCE[0]}))

GREEN='\[\033[32m\]'
WHITE='\[\033[37m\]'
WHITEBG='\[\033[47m\]'
NORM='\[\033[00m\]'
BLUE='\[\033[34m\]'

# set a fancy prompt
if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}'$GREEN'\u@\h'$NORM':'$BLUE'\w'$NORM'$(__git_ps1 " (%s)")\n'$WHITE'\$ '$NORM''
#	trap 'echo -ne "\e[0m"' DEBUG # for closing the colored input prompt
fi
unset color_prompt force_color_prompt

# print shell title: last 20 characters of $PWD
export PROMPT_COMMAND='echo -en "\033]0; ${PWD:${#PWD}<20?0:-20} \a"'

# git prompt
#GIT_PROMPT_START='${debian_chroot:+($debian_chroot)}\u@\h:\w'    # uncomment for custom prompt start sequence
#GIT_PROMPT_END='\n\$ '
#GIT_PROMPT_ONLY_IN_REPO=0
#GIT_PROMPT_FETCH_REMOTE_STATUS=0
#GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0
#GIT_PROMPT_SHOW_UNTRACKED_FILES=no
#source $REALPWD/bash-git-prompt/gitprompt.sh

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

export GVIM_ENABLE_WAYLAND=true
