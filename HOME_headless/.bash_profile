#
# ~/.bash_profile
#

# set PATH so it includes user's private bin if it exists
[[ -d ~/bin ]] && PATH=~/bin:"${PATH}"
[[ -d ~/.bscripts ]] && PATH=~/.bscripts:"${PATH}"
export PATH


## include .bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc


