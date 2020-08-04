#!/bin/bash 
function f_inetd {
    ## inetd services
    if [[ $(dpkg -s xinetd 2> /dev/null) == "is not installed" ]]; then
        echo "xinetd already remove"
    else
        sudo apt purge xinetd -y
    fi

    if [[ $(dpkg -s openbsd-inetd 2> /dev/null) == "is not installed" ]]; then
        echo "openbsd-inetd already remove"
    else
        sudo apt purge openbsd-inetd -y
    fi
}

function f_sps {
    ### Special purpose services 
    ##time sync & chrony
    if [[ $(systemctl is-enabled systemd-timesyncd) == enabled ]] | [[ $(dpkg -s chrony 2> /dev/null) == "is not installed" ]]; then
        sudo apt install chrony -y
    else
        echo "chrony already installed"
    fi

    ##time sync & ntp
    if [[ $(dpkg -s ntp 2> /dev/null) == "is not installed" ]]; then
        sudo apt install ntp -y
    else
        echo "ntp already installed"
    fi

}


###Untuk test script fungsi nee

# f_inetd

f_sps
