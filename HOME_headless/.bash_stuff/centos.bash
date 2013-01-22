#!/bin/bash

if [[ "$(cat /etc/*release | grep -io centos | sort -u)" == "centos" ]]; then
    unalias which
    #alias which='/usr/bin/which'
#[[ -f /usb/bin/which ]] && alias which='/usr/bin/which'
fi
