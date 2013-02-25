#!/bin/bash

# screen
SCREEN=/usr/bin/screen
function screen () {
  MSG=$( ${SCREEN} "${@}" )
  if [[ "${MSG:0:25}" == "Cannot open your terminal" ]]; then
      CMD="'screen ${@}'"
      eval script /dev/null -c ${CMD} 
  else
      echo -e "${MSG}"
  fi
}

alias sc='screen'
alias sN='screen -S'
alias srx='screen -rx'
alias rx='screen -rx'
alias sls='screen -ls'
alias scls='screen -ls'
alias sdr='screen -D -R'
alias sdrr='screen -D -RR'
alias rxdr='screen -D -R'
alias rxdrr='screen -D -RR'

