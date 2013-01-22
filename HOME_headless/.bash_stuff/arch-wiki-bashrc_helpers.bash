#!/bin/bash

# https://wiki.archlinux.org/index.php/Bashrc_helpers

# todo()  note()  extract()  docview()  calc()  kingbash

TODO_ON=1
NOTE_ON=1
EXTRACT_ON=1
DOCVIEW_ON=1
CALC_ON=1
KINGBASH_ON=0
# yaourt -S kingbash



[[ ${TODO_ON} == 1 ]] &&
todo() {
   test -f $HOME/.todo || touch $HOME/.todo
   if test $# = 0
   then 
           cat $HOME/.todo
   elif test $1 = -l
   then
           cat -n $HOME/.todo
   elif test $1 = -c
   then
           > $HOME/.todo
   elif test $1 = -r
   then
           cat -n $HOME/.todo
           echo -ne "----------------------------\nType a number to remove: "
           read NUMBER
           sed -ie ${NUMBER}d $HOME/.todo
   else
           echo $@ >> $HOME/.todo
   fi
}


[[ ${NOTE_ON} == 1 ]] &&
note ()
{
       #if file doesn't exist, create it
       [ -f $HOME/.notes ] || touch $HOME/.notes
       #no arguments, print file
       if [ $# = 0 ]
       then
               cat $HOME/.notes
       #clear file
       elif [ $1 = -c ]
       then
               > $HOME/.notes
       #add all arguments to file
       else
               echo "$@" >> $HOME/.notes
       fi
}


[[ ${EXTRACT_ON} == 1 ]] &&
extract() {
 local e=0 i c
 for i; do
   if [[ -f $i && -r $i ]] ; then
       c=
       case $i in
         *.tar.bz2) c='tar xjf'    ;;
         *.tar.gz)  c='tar xzf'    ;;
         *.bz2)     c='bunzip2'    ;;
         *.gz)      c='gunzip'     ;;
         *.tar)     c='tar xf'     ;;
         *.tbz2)    c='tar xjf'    ;;
         *.tgz)     c='tar xzf'    ;;
         *.7z)      c='7z x'       ;;
         *.Z)       c='uncompress' ;;
         *.exe)     c='cabextract' ;;
         *.rar)     c='unrar x'    ;;
         *.xz)      c='unxz'       ;;
         *.zip)     c='unzip'      ;;
         *)     echo "$0: cannot extract \`$i': Unrecognized file extension" >&2; e=1 ;;
       esac
       [[ $c ]] &&  command $c "${i}"
   else
       echo "$0: cannot extract \`$i': File is unreadable" >&2; e=2
   fi
 done
 return $e
}



[[ ${DOCVIEW_ON} == 1 ]] &&
docview ()
{
  if [ -f $1 ] ; then
      case $1 in
          *.pdf)       xpdf $1    ;;
          *.ps)        oowriter $1    ;;
          *.odt)       oowriter $1     ;;
          *.txt)       leafpad $1       ;;
          *.doc)       oowriter $1      ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}



[[ ${CALC_ON} == 1 ]] &&
calc() { echo "scale=3;$@" | bc -l ; }



[[ ${KINGBASH_ON} == 1 ]] &&
function kingbash.fn() {
  echo -n "KingBash> $READLINE_LINE" #Where "KingBash> " looks best if it resembles your PS1, at least in length.
#  echo -n "${PS1} $READLINE_LINE"
  OUTPUT=`/usr/bin/kingbash "$(compgen -ab -A function)"`
  READLINE_POINT=`echo "$OUTPUT" | tail -n 1`
  READLINE_LINE=`echo "$OUTPUT" | head -n -1`
  echo -ne "\r\e[2K"; }
[[ ${KINGBASH_ON} == 1 ]] &&
bind -x '"\t":kingbash.fn'

