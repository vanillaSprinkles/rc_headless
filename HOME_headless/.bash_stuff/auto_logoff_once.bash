#!/bin/bash
#workDir="/tmp/$(id -un)/bash_stuff"
workDir="/tmp"
tfile="${workDir}/auto_logoff_once"
tfile2="${workDir}/auto_logoff_once2"

if [[ ! -e ${tfile} ]]; then
  mkdir -p $workDir
  touch $tfile
  vlock 
  exit
#elif [[ ! -e ${tfile2} ]]; then
#  mkdir -p $workDir
#  touch $tfile2
#  exit
fi




