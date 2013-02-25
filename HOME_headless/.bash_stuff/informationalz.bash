#!/bin/bash

alias hardwareInfo="echo -e ' lspci -vv\n hwinfo\n dmidecode'"



function hdd_info () {
    # echo "http://hardforum.com/showthread.php?t=1590200"
    echo "TLER:  # error control"
    echo -e "  display TLER (explicit for RAID):"
    echo -e "    smartctl -l scterc <dev>"
    echo -e "  set TLER:"
    echo -e "    smartctl -l scterc,70,70 <dev>  # def for RAID"
    echo -e "    smartctl -l scterc,0,0  <dev>  #  TLER disabled"

    echo -e "Firmware info:\n  smartctl -a <dev> | grep Firmware"

    echo -e "query power-state:\n  hdparm -C <dev>\n"
    echo "head parking parameters (sleep after idle), not-persistent settings:"
    echo '  hdparm -S 252 <dev>   # numeric range depends on device?'
    echo -e " query Idle Time:\n hdparm -I /dev/sdb | grep level   # not on satas?"

    echo -e "\n/etc/hdparm.conf\n /dev/sda {\n  #spindown_time = 60  # 5 min\n  #spindown_time = 240 # 20 min"
    echo -e "  #spindown_time = 250 # 30 min\n  #spindown_time = 280 # 1 hour\n  spindown_time = 340 # 2 hours\n}"
    
    echo -e "\nLCC (Load Cycle Count (for Green HDDs)\nhttps://wiki.archlinux.org/index.php/Advanced_Format#Disable_via_hdparm:\n   #better to use WDIDLE3.EXE\n   hdparm -J 300 --please-destroy-my-drive <dev>"
}
