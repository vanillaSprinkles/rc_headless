#!/bin/bash

# history in multiple windows-appendage
shopt -s histappend
PROMPT_COMMAND='history -a'
# dynamic resizing
shopt -s checkwinsize

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

#eval `ssh-agent`
#[ -f /usr/bin/keychain ] && /usr/bin/keychain -Q -q --nogui ~/.ssh/id_dsa
#[ -f /usr/bin/keychain ] && /usr/bin/keychain -Q -q --nogui ~/.ssh/id_rsa
#/usr/bin/keychain -Q -q --nogui ~/.ssh/id_dsa
#/usr/bin/keychain -Q -q --nogui ~/.ssh/id_rsa
#[ -f $HOME/.keychain/$HOSTNAME-sh ] && source $HOME/.keychain/$HOSTNAME-sh
if [ -f ~/.github ]; then
  . ~/.github
fi

#stty -ixon
stty -ixon -ixoff


# gcc / g++ #includes
#export LIBRARY_PATH="/usr/include /usr/include/linux"


