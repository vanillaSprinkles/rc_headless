#!/bin/bash


function teamviewerLaunch () {
    sudo systemctl start teamviewerd

    echo -e "\n\nsudo systemctl start teamviewerd\n"

    echo -e "now run 'teamvieer'"


    echo -e "top stop use either:"
    echo -e " sudo systemctl stop teamviewerd"
    echo -e " teamviewerStop"

}


function teamviewerStop () {
    killall teamviewer
    sudo systemctl stop teamviewerd
}
