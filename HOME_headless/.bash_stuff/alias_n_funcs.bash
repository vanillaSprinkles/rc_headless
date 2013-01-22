#!/bin/bash

## testing


## end testing

###### Alias's

alias ReSource='source ${HOME}/.bash_profile; ping 127.0.0.1 -c 2 > /dev/null'
alias ReSourceR='reset; source ${HOME}/.bash_profile; ping 127.0.0.1 -c 2 > /dev/null'

#alias ls='ls --color=auto'
alias ls='ls --color=auto'
alias lL='ls -lh'
alias ll='ls -Alh'
alias li='ll -i'
alias lT='ls -Alh --sort=time'
alias l='li'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias cpa='cp -a'
alias cpaf='cp -af'
alias less='less -R'
alias head='head -n 20'
alias cd..='cd ..'
alias cd..ll='cd ..; ll'


alias ccrap='echo "";rm -fv *~;rm -fv \#*\#;rm -fv \.*~;rm -fv \.\#*\#;echo ""; ls -ah'

alias grep='grep --color=always'
alias cower='cower --color=always'

alias ps='ps --forest'
#alias screenie='scrot -m -t 50 "snap_%Y-%m-%d_%T.png" -e "mv snap_* /home/snaps/." ' #-e "mv snap_* /home/websites/main/snaps"'
alias screenie='scrot -m -t 50 "snap_%Y-%m-%d_%H%M%S.png" -e "mv snap_* /home/snaps/.; exec /home/dropboxer/dropboxer.sh index" ' #-e "mv snap_* /home/websites/main/snaps"'

alias indexDropbox='/home/dropboxer/dropboxer.sh index.html'
alias DropboxIndex='indexDropbox'

alias netstatNET='netstat -alnp --protocol=inet | grep -v CLOSE_WAIT | cut -c-6,21-99 | tail -n +2'

# mouse sensativity
alias mrd='xset m 0 0 &'
alias mtp='xset m 4 5 &'

alias fehS='feh -dZ.Y --min-dimension 0x768 -B black'


emcas='emacs'
emacsRO() {
    emacs "$1" --eval '(setq buffer-read-only t)'
}



# chmod stuff
#find . -type d -exec chmod 755 {} \;
#find . -type f -exec chmod 644 {} \;
### fix these!!! ###
alias 775d='find . -type d -exec chmod 775 {} \;'
alias 774d='find . -type d -exec chmod 774 {} \;'
alias 770d='find . -type d -exec chmod 770 {} \;'
alias 665f='find . -type f -exec chmod 665 {} \;'
alias 664f='find . -type f -exec chmod 664 {} \;'
alias 660f='find . -type f -exec chmod 660 {} \;'
alias 440f='find . -type f -exec chmod 440 {} \;'
alias chmod_exes='find . \( -name "*.sh" -o -name "*.app" -o -name "*.x" -o -name "*.X" -o -name "*.lexe" \) -exec chmod +x {} +;'
alias chmoddir="find . -type d -exec chmod ${@} {} \;"
alias chmodfile="find . -type f -exec chmod ${@} {} \;"

#find . -name \*.sh -type f
# find . -type f | grep -s ".*\.sh$" | while read file; do  chmod +x "${file}"; done;
# find . -type f | grep -s ".*\.app$" | while read file; do  chmod +x "${file}"; done;
# find . -type f | grep -s ".*\.x$" | while read file; do  chmod +x "${file}"; done;
# find . -type f | grep -s ".*\.X$" | while read file; do  chmod +x "${file}"; done; '
## find . -name '*.sh' -o -name '*.app' -o -name '*.x' -o -name '*.X' -exec chmod +x {} \;
## find . \( -name '*.sh' -o -name '*.app' -o -name '*.x' -o -name '*.X' \) -exec chmod +x {} + ;
alias 755d='find . -type d -exec chmod 755 {} \;'
alias 644f='find . -type f -exec chmod 644 {} \;'
alias 775f='find . -type f -exec chmod 775 {} \;'
alias chmodug='664f; 775d'








#

###### end alias's
#####

#

#####
###### Functions

###

###



### bmp to jpg 
# single folder
function bmp-jpg-folder () {
    if [[ "${1}" == "" ]]; then
        dir="."
    else
        dir="${1}"
        if [[ "${dir#${dir%?}}" != "/" ]]; then
            dir="${1}/"
        fi
    fi

    find ${dir} -maxdepth 1 -type f -iname "*.bmp" | while read line; do
        ext=`echo ${line} | awk  -F . '{print $NF}'`
        convert "${line}" "${line%$ext}""jpg"
    done

}
# end single folder

# recursive
function bmp-jpg-recursive () {
    if [[ "${1}" == "" ]]; then
	dir="."
    else
	dir="${1}"
	if [[ "${dir#${dir%?}}" != "/" ]]; then
	    dir="${1}/"
	fi
    fi

    find ${dir} -type f -iname "*.bmp" | while read line; do
	ext=`echo ${line} | awk  -F . '{print $NF}'`
	convert "${line}" "${line%$ext}""jpg"
    done

} 
# end recursive

function bmp-jpg-folder-die () {
    if [[ "${1}" == "" ]]; then
        dir="."
    else
        dir="${1}"
        if [[ "${dir#${dir%?}}" != "/" ]]; then
            dir="${1}/"
        fi
    fi

    find ${dir} -maxdepth 1 -type f -iname "*.bmp" | while read line; do
        ext=`echo ${line} | awk  -F . '{print $NF}'`
        convert "${line}" "${line%$ext}""jpg" &&  rm -f "${line}"
    done

}
# end single folder-die

# recursive-die
function bmp-jpg-recursive-die () {
    if [[ "${1}" == "" ]]; then
        dir="."
    else
        dir="${1}"
        if [[ "${dir#${dir%?}}" != "/" ]]; then
            dir="${1}/"
        fi
    fi

    find ${dir} -type f -iname "*.bmp" | while read line; do
        ext=`echo ${line} | awk  -F . '{print $NF}'`
        convert "${line}" "${line%$ext}""jpg" &&  rm -f "${line}"
    done

}
# end recursive-die
alias bmp2jpg-f='bmp-jpg-folder'
alias bmp2jpg-f-die='bmp-jpg-folder-die'
alias bmp2jpg-subdir='bmp-jpg-recursive'
alias bmp2jpg-subdir-die='bmp-jpg-recursive-die'
### end  bmp to jpg




### re-scan scsi (sata) devices
alias resata='reSata'
function reSata () {
    for i in /sys/class/scsi_host/*; do echo "- - -" > ${i}/scan; done
}
### end  re-scan devices   function


###  window-title (putty / xterm)
### SEE   ps1.bash
# function wtitle
#function wtitle {
#    if [ "$TERM" == "xterm" ] ; then
#        # Remove the old title string in the PS1, if one is already set.
#       PS1=`echo $cPS1 | sed -r 's/^\\\\\[.+\\\\\]//g'`
#       export PS1="\[\033]0;$1 - \u@\h:\w\007\]${cPS1}"
#}
##        PS1=`echo $PS1 | sed -r 's/^\\\\\[.+\\\\\]//g'`
##        export PS1="\[\033]0;$1 - \u@\h:\w\007\]${PS1}"
##        source ~/.bash_stuff/ps1.bash
#    else
#       echo "You are not working in xterm. I cannot set the title."
#    fi
###  end window-title


# easy extraction
function extract () {
    if [ -f $1 ] ; then
	case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don't know how to extract '$1'..." ;;
	esac
    else
	echo "'$1' is not a valid file!"
    fi
}
### end   extract   function


# easy 7z compress with password
function 7zPw () {
    if [ -z $1 ]; then
	echo "7zPw <name of new archive>.7z <files to include> <optional: password>"
    else
	datime=`date '+%Y-%m-%d_%H.%M.%S'`
	7za a -mhe "${1}_${datime}.7z" "${2}"  -p"${3}"
	echo '7za a -mhe "${1}_${datime}.7z" "${2}"  -p"${3}"'
    fi
}
### end easy 7z compress with password



## the best way to startx with a specified window manager
## next script to allow 2 parameters, one is screen, other is WM; if no screen then first is WM
# screen hide/detach wm
# function x_OLD_BASH_FUNC
x_OLD_BASH_FUNC () {

    ReD='\033[0;31m';    GrN='\033[0;32m';    DeF='\033[0m';

    scr_hid=0;    wm=0;    mode=0
    if [[ "${1}" == "screen" || "${1}" == "hide" ]]; then
	scr_hid=1
    elif [[ "${2}" == "screen" || "${2}" == "hide" ]]; then
	scr_hid=2
    fi

    # assign wm/mode appropriate text values
    wms=`pacman -Qs window manager | /usr/bin/grep "^local" | sed "s/^local\///" | awk '{ if ($1 != "obconf" && $1 != "screen" && $1 != "screen-vs" && $1 != "xcb-util-wm") print $1}'`
    for i in $wms; do
	if [[ "$i" == "i3-git" ]]; then wms="${wms} i3"; fi
	if [[ "$i" == "wmii-hg" ]]; then wms="${wms} wmii"; fi
    done
    match=0
    if [[ $scr_hid == 1 ]]; then
	mode=${1};	wm=${2};
	for i in $wms; do	if [[ "$i" == "${wm}" ]]; then match=1; fi;    done
	if (( $match==0 )); then
	    echo -e "${ReD}x: invalid operand\n${DeF}Useage: x <window manger> [hide | screen]"
	    echo -en "  Window Magers: ";  for x in $wms; do   echo -e -n "${x}  ";	done;	echo -e "${DeF}"
	    return
	fi
    elif [[ $scr_hid == 2 ]]; then
	mode=${2};	wm=${1};
	for i in $wms; do	if [[ "$i" == "${wm}" ]]; then match=1; fi;    done
	if (( $match==0 )); then
	    # glitches here
	    echo -e "${ReD}x: invalid  window manager: '${wm}', exiting.'${DeF}"
	    echo -en "  Window Magers: ";  for x in $wms; do   echo -e -n "${x}  ";	done;	echo -e "${DeF}"
	    return
	fi
    else
	for i in $wms; do	if [[ "$i" == "${1}" ]]; then match=1; fi;    done
	if (( $match==0 )); then
	    for i in $wms; do	if [[ "$i" == "${2}" ]]; then match=1; fi;    done
	    if (( $match==0)); then
		echo -e "${ReD}x: invalid operand\n${DeF}Useage: x <window manger> [hide | screen]"
		echo -en "  Window Magers: ";  for x in $wms; do   echo -e -n "${x}  ";	done;	echo -e "${DeF}"
		return
	    else
		wm=${2};	    mode=3  # wm in {2} and error in {1}
		echo -e "warning: invalid run mode\n${DeF}  use either: 'hide' or 'screen' or neither"
	    fi
	else
	    wm=${1};  mode=0;
	    if [ ! -z ${2} ]; then echo -e "warning: invalid run mode\n${DeF}  use either: 'hide' or 'screen' or neither"; fi
	fi
    fi

    if [[ "${wm}" == 'i3-git' ]]; then
	    wm="i3"
    else
	if [[ "${wm}" == 'wmii-hg' ]]; then
	    wm="wmii"
	fi
    fi

    # deal with the .xinitrc file
    if [ ! -h $HOME/.xinitrc ]; then
	if [ -f $HOME/.xinitrc ]; then
	    datime=`date '+%Y-%m-%d_%H.%M.%S'`;	    mv $HOME/.xinitrc ${HOME}/.xinitrc_${datime}
	    echo -e "${ReD}${HOME}.xinitrc file found, renaming to: ${HOME}/.xinitrc_${datime}\n${GrN}Use ~/.xinitrc.extra for additional settings${DeF}"
	fi;
	touch /tmp/${USER}_xinitrc;	ln -s /tmp/${USER}_xinitrc .xinitrc
    fi
    touch ${HOME}/.xinitrc.extra

    /bin/cp -f ${HOME}/.xinitrc.extra /tmp/${USER}_xinitrc;    echo -e "\n\nexec ${wm}" >> /tmp/${USER}_xinitrc
    
    case ${mode} in
	hide)
	    /usr/bin/startx 1>&- 2>&- &	    ;;
	screen)
	    screen -d -m -S "startx_${wm}" /usr/bin/startx	    ;;
	*)
	    /usr/bin/startx	    ;;
    esac
}
### end   x   function




### flac to mp3 
function flacTo320cbr () {
    for a in *.flac
    
    do
	OUTF=`echo "$a" | sed s/\.flac$/.mp3/g`
	
	ARTIST=`metaflac "$a" --show-tag=ARTIST | sed s/.*=//g`
	TITLE=`metaflac "$a" --show-tag=TITLE | sed s/.*=//g`
	ALBUM=`metaflac "$a" --show-tag=ALBUM | sed s/.*=//g`
	GENRE=`metaflac "$a" --show-tag=GENRE | sed s/.*=//g`
	TRACKNUMBER=`metaflac "$a" --show-tag=TRACKNUMBER | sed s/.*=//g`
	DATE=`metaflac "$a" --show-tag=DATE | sed s/.*=//g`
	
#flac -c -d "$a" | lame -m j -q 0 --vbr-new -V 0 -s 44.1 - "$OUTF"
	flac -c -d "$a" | lame -m j -q 0  -b 320  -s 44.1 - "$OUTF"
	id3 -t "$TITLE" -T "${TRACKNUMBER:-0}" -a "$ARTIST" -A "$ALBUM" -y "$DATE" -g "${GENRE:-12}" "$OUTF"
	
    done
}

### end flac to mp3



### flac to mp3 xCBR
function flacToXcbr () {
    for a in *.flac
    
    do
	OUTF=`echo "$a" | sed s/\.flac$/.mp3/g`
	
	ARTIST=`metaflac "$a" --show-tag=ARTIST | sed s/.*=//g`
	TITLE=`metaflac "$a" --show-tag=TITLE | sed s/.*=//g`
	ALBUM=`metaflac "$a" --show-tag=ALBUM | sed s/.*=//g`
	GENRE=`metaflac "$a" --show-tag=GENRE | sed s/.*=//g`
	TRACKNUMBER=`metaflac "$a" --show-tag=TRACKNUMBER | sed s/.*=//g`
	DATE=`metaflac "$a" --show-tag=DATE | sed s/.*=//g`
	
#flac -c -d "$a" | lame -m j -q 0 --vbr-new -V 0 -s 44.1 - "$OUTF"
	flac -c -d "$a" | lame -m j -q 0  -b ${1}  -s 44.1 - "$OUTF"
	id3 -t "$TITLE" -T "${TRACKNUMBER:-0}" -a "$ARTIST" -A "$ALBUM" -y "$DATE" -g "${GENRE:-12}" "$OUTF"
	
    done
}

### end flac to mp3 xCBR



### flac to mp3 V2
function flacToV2 () {
    for a in *.flac

    do
	OUTF=`echo "$a" | sed s/\.flac$/.mp3/g`
	
	ARTIST=`metaflac "$a" --show-tag=ARTIST | sed s/.*=//g`
	TITLE=`metaflac "$a" --show-tag=TITLE | sed s/.*=//g`
	ALBUM=`metaflac "$a" --show-tag=ALBUM | sed s/.*=//g`
	GENRE=`metaflac "$a" --show-tag=GENRE | sed s/.*=//g`
	TRACKNUMBER=`metaflac "$a" --show-tag=TRACKNUMBER | sed s/.*=//g`
	DATE=`metaflac "$a" --show-tag=DATE | sed s/.*=//g`

	flac -c -d "$a" | lame -m j -q 0 --vbr-new -V 2 -s 44.1 - "$OUTF"
#       flac -c -d "$a" | lame -m j -q 0  -b ${1}       -s 44.1 - "$OUTF"
        id3 -t "$TITLE" -T "${TRACKNUMBER:-0}" -a "$ARTIST" -A "$ALBUM" -y "$DATE" -g "${GENRE:-12}" "$OUTF"

    done
}

### end flac to mp3 V2




### batch rename 1
function bRename1 () {
    # for file in /path/to/*; do echo mv "$file" "${file/abc-two_/}"; done
    echo -e 'for file in ./*; do mv "$file" "${file/\_replace shit here_/with this string}"; done'
}
### end batch rename 1
