#!/bin/bash


function INFOZ () {
  cat <<EOF 
informationalz.bash commands:
  hardwareInfo
  HardwareInfo
  hdd_info
  sedNL  (how to sed for newline) 
EOF
}


alias hardwareInfo="echo -e ' lspci -vv\n hwinfo\n dmidecode'"
alias HardwareInfo="echo -e ' lspci -vv\n hwinfo\n dmidecode'"


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


function sedNL () {

cat <<EOF
SED for new-line \n

sed ':a;N;$!ba;s/\n/ /g'

This will read the whole file in a loop, then replaces the newline(s) with a space.

Update: explanation.

   1. create a label via :a
   2. append the current and next line to the pattern space via N
   3. if we are before the last line, branch to the created label $!ba ($! means not to do it on the last line (as there should be one final newline)).
   4. finally the substitution replaces every newline with a space on the pattern space (which is the whole file).

EOF

  return
printf %s "\
sed ':a;N;$!ba;s/\n/ /g'

This will read the whole file in a loop, then replaces the newline(s) with a space.

Update: explanation.

    create a label via :a
    append the current and next line to the pattern space via N
    if we are before the last line, branch to the created label $!ba ($! means not to do it on the last line (as there should be one final newline)).
    finally the substitution replaces every newline with a space on the pattern space (which is the whole file).
"

}
