#!/bin/bash

function help () {
    echo "help:"
    echo " (Install || InstallWork || InstallHeadless)   <GitHub-rc-base>   <destination folder>  --symlink-user=<pick-a-user>  -o symlink-user=<USR>,"
# move base
# 
### look for   vanillaSprinkles.rc.conf
##  stores  '$(hostname) $(id -u)'  for users that use symlink rc-files

    echo "  installs either the standard rc, Work/Headless files from the GitHub-rc-base to the destination folder"
    exit
}

[ -z $1 ] && help

mode=${1}
base=${2}
dest=${3}

echo "rarw"
