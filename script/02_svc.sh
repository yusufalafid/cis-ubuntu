#!/bin/bash 
function f_inetd {
    ## inetd services
    if [[ $(dpkg -s xinetd 2> /dev/null) == "dpkg-query: package 'xinetd' is not installed" ]]; then
        echo "xinetd already remove"
    else
        sudo apt purge xinetd
    fi

    if [[ $(dpkg -s openbsd-inetd 2> /dev/null) == "dpkg-query: package 'xinetd' is not installed" ]]; then
        echo "openbsd-inetd already remove"
    else
        sudo apt purge openbsd-inetd
    fi
}

function f_sps {
    ### Special purpose services 
    ##time sync & ntp
    if [[ $(systemctl is-enabled systemd-timesyncd) == enabled ]] | [[ $(dpkg -s chrony 2> /dev/null) == "dpkg-query: package 'chrony' is not installed" ]]; then
        echo "no chrony installed"
    else
        sudo apt install chrony
    fi

    ##time sync & ntp
    if [[ $(dpkg -s ntp 2> /dev/null) == "dpkg-query: package 'chrony' is not installed" ]]; then
        echo "no ntp installed"
    else
        sudo apt install ntp
    fi

}

#f_inetd

f_sps
