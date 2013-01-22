#!/bin/bash

# git hub stuff
# Git Aliases
alias gitb="git branch -a -v"
alias gitba="git branch -a"
alias gitbl="git branch -l"
alias gitbr="git branch -r"
alias gits="git status"
alias gitstatus="git status"
alias gitd="git diff"
alias gitdiff="git diff"
alias gitca="git commit -a"
alias gitcommita="git commit -a"
alias gitpo="git push origin "
alias gitpom="git push origin master"
alias gitpostable="git push origin stable"
alias gitpotest="git push origin testing"
alias gitpodebug="git push origin debugging"
alias gitco="git checkout "
alias gitcm="git checkout master "
alias gitclo="git clone "  # https://github.com/dumbterminal/DT-Firewall.git
alias gitp="git pull "
alias gitx="gitx"
alias gitmm="git merge master"
alias gitcb="git-create-branch"
# gc      => git checkout master
# gc bugs => git checkout bugs
function gitco {
  if [ -z "$1" ]; then
      git checkout master
  else
      git checkout $1
  fi
}
ghclone ()
{
    gh_url=${1:-`pbpaste`};
    co_dir=${HOME}/Code/sources/$(echo $gh_url | sed -e 's/^git:\/\/github.com\///; s/\//-/; s/\.git$//');
    if [ -d $co_dir ]; then
        cd $co_dir && git pull origin master;
    else
        git clone "${gh_url}" "${co_dir}" && cd "${co_dir}";
    fi
}
# end git hub
