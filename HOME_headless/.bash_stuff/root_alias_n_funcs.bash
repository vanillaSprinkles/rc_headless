#!/bin/bash
if [ $USER == "root" ]; then


### alias's 


alias slowReboot="ping 127.0.0.1 -c 10 -t 1  &&  shutdown -r now"



#


### functions
#

newUser() {
    uuid=`cat /etc/passwd | cut -d':' -f3 | sort -n | tail -n 1`
    [[ "${uuid}" < 20000 ]] && uuid = 20000
    ((uuid++))
#    echo ${uuid}
    
    usr="${1}"
    pas="${2}"
#    group="${3}"
    shel="${3}"
    base="${4}"
    folder="${5}"
#    [[ -z ${1} ]] && echo "parameters: User Pass Group Shell Base Folder" && exit
#    [[ -z ${5} ]] && echo "parameters: User Pass Group Shell Home-Base Home-Folder" && exit
    [[ -z ${1} ]] && echo "parameters: User Pass Shell Base Folder" && return
    [[ -z ${5} ]] && echo "parameters: User Pass Shell Home-Base Home-Folder" && return
    

    echo    useradd -b "${base}" -d "${base}/${folder}"  -m -p "${pas}" -s "${shel}" -u ${uuid} -U "${usr}"
    useradd -b "${base}" -d "${base}/${folder}"  -m -p ${pas} -s "${shel}" -u ${uuid} -U "${usr}"
#    useradd -b /ExtraHDD/vsftpd_homez -d /ExtraHDD/vsftpd_homez/trust  -m -p 105t4W0rd5 -s /bin/bash -u ${uuid} -U thetrust
# useradd -M -u 20003 -U vsftpduser -s /bin/false
    
#    if [


}


pacs() {
    local CL='\\e['
    local RS='\\e[0;0m'
    
    echo -e "$(pacman -Ss ${@} | sed "
    /\[installed\]$/s,.*,${CL}0;33m&${RS},
    /^core/s,.*,${CL}1;31m&${RS},
    /^extra/s,.*,${CL}0;32m&${RS},
    /^community/s,.*,${CL}1;35m&${RS},
    /^[^[:space:]]/s,.*,${CL}0;36m&${RS},
   ")"
}

pacq() {
    local CL='\\e['
    local RS='\\e[0;0m'
    
    echo -e "$(pacman -Qs ${@} | sed "
    /\[installed\]$/s,.*,${CL}0;33m&${RS},
    /^core/s,.*,${CL}1;31m&${RS},
    /^extra/s,.*,${CL}0;32m&${RS},
    /^community/s,.*,${CL}1;35m&${RS},
    /^[^[:space:]]/s,.*,${CL}0;36m&${RS},
    ")"
}

pacl() {
    repoz=`grep -v '^\[options\]' /etc/pacman.conf | grep '^\[.*\]' | sed -e 's/^\[\([^]]*\)\]$/\1/g'`
    repo=''
    if [[ -z $1 ]]; then 
	echo -e "invalid parameter: use a repo or 'all' for all\nrepos available:"
	for rep in $repoz; do  echo -n "  ${rep}";  done
	echo ""
	return
    elif [[ $1 != 'all' ]]; then repo=$1; fi

    local CL='\\e[';  local RS='\\e[0;0m'
    
    echo -e "$(pacman -Sl ${repo} | sed "
    /\[installed\]$/s,.*,${CL}0;33m&${RS},
    ")"
}




fi
