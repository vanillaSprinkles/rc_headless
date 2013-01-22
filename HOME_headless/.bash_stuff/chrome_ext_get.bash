#!/bin/bash
chrome_ext_dl_dir="${HOME}/Downloads/chrome_ext_grab"

chrome_ext_get () {

    ReD='\033[0;31m'
    GrN='\033[0;32m'
    DeF='\033[0m'
    
    class=${1}; if [[ "${class}" == "ext" ]]; then class="extension"; fi
    uuid=${2}
    file=${3}
    
    if [ -z ${class} ] || [ -z ${uuid} ]; then
	echo    'not enough parameters!'
	echo    " chrome_ext_get <app||extension||theme>  <chrome-uuid> <chrome-ext-name>[<.crx>]"
	echo -e "    IE: https://chrome.google.com/webstore/detail/${GrN}into-the-mist${DeF}/${ReD}mgihmkgobaljfehcadcckdggpeojaadh${DeF}/"
	echo -e "  chrome_ext_get theme ${ReD}mgihmkgobaljfehcadcckdggpeojaadh${GrN} IntoTheMist${DeF}.crx"
	return	
    fi
    
    
    if [[ "${class}" != "app" && "${class}" != "extenstion" && "${class}" != "theme" ]]; then
	class=""
    fi
    chrome_ext_dl_dir=${chrome_ext_dl_dir}/${class}


    if [ -n `echo ${uuid} | grep -i "chrome.google.com"` ]; then
	uuid=`echo "${uuid}/" | grep -i "chrome.google.com" | grep -Eo "/[a-z]{32}/" | cut -d'/' -f2`
    fi
    

    if [ -z ${file} ]; then 
	echo    'no file name specified, using chrome-uuid!'
	echo    "filename ${uuid}.crx"
	file=${uuid}
    fi
    
    ofile="${file%%.*}"
    
    echo -e wget "https://clients2.google.com/service/update2/crx?response=redirect&x=id%3D${ReD}"${uuid}"${DeF}%26uc" -O "${chrome_ext_dl_dir}/${GrN}${ofile}${DeF}.crx\n"

    mkdir -p ${chrome_ext_dl_dir}

#http://productforums.google.com/forum/#!topic/chrome/g02KlhK12fU
#was able to get them via the text-based browser "lynx". Open up lynx in terminal, and (g)o to "https://clients2.google.com/service/update2/crx?response=redirect&x=id%3D<extension>%26uc" 

    wget "https://clients2.google.com/service/update2/crx?response=redirect&x=id%3D"${uuid}"%26uc" -O "${chrome_ext_dl_dir}/${ofile}.crx"

    

}
