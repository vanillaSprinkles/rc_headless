#!/bin/bash

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

