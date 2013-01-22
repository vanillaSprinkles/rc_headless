#!/bin/bash

uPS1='${debian_chroot:+($debian_chroot)}\[\033[01;92m\][\[\033[00;94m\]\u\[\033[00;90m\]@\h\[\033[00m\] \[\033[96m\]\w\[\033[01;92m\]]\[\033[00;31m\]\$\[\033[00m\] '
rPS1='${debian_chroot:+($debian_chroot)}\[\033[01;92m\][\[\033[00;91m\]\u\[\033[00;90m\]@\h\[\033[00m\] \[\033[96m\]\w\[\033[01;92m\]]\[\033[00;05;31m\]\$\[\033[00m\] '

cPS1=""

# If not running interactively, don't do anything
[[ $- != *i* ]] && return



# PS1='[\u@\h \W]\$ '

cPS1=${uPS1}
#PS1='\[\033[01;92m\][\[\033[00;94m\]\u\[\033[00;90m\]@\h\[\033[00m\] \[\033[96m\]\w\[\033[01;92m\]]\[\033[00;31m\]\$\[\033[00m\] '
if [ $USER == "root" ]; then
cPS1=${rPS1}
fi

PS1=${cPS1}


###  window-title (putty / xterm)
function wtitle {
#    if [ "$TERM" == "xterm" ] ; then
#        # Remove the old title string in the PS1, if one is already set.
#       PS1=`echo $cPS1 | sed -r 's/^\\\\\[.+\\\\\]//g'`
       export PS1="\[\033]0;$1 - \u@\h:\w\007\]${PS1}"
}
#       export PS1=${cPS1}
#    else
#      echo "You are not working in xterm. I cannot set the title."
#    fi
#}
###  end window-title

