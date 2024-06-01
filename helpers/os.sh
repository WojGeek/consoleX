#!/bin/bash

set -e

detect_arch() {
    if [ "$(uname -s)" = "Darwin" ] && [ "$(uname -m)" = "x86_64" ]; then
        target="x86_64-apple-darwin"
    elif [ "$(uname -s)" = "Darwin" ] && [ "$(uname -m)" = "arm64" ]; then
        target="aarch64-apple-darwin"
    elif [ "$(uname -s)" = "Linux" ] && [ "$(uname -m)" = "x86_64" ]; then
        target="x86_64-linux"
    elif [ "$(uname -s)" = "Linux" ] && [ "$(uname -m)" = "aarch64" ]; then
        target="aarch64-linux"
    elif [ "$(uname -s)" = "Linux" ] && ( uname -m | grep -q -e '^arm' ); then
        target="arm-unknown-linux"
    else
        echo "Unsupported OS or architecture"
        return
    fi
    echo  $target
    
}



detect_os() {
    
    ARCH=$(detect_arch);
    #ARCH="${MACHINETYPE}";
    OS_DERIVATES='Not identified'
    
    DEB_TYPE="(Debian|Ubuntu|Mint|Parrot)"
    RPM_TYPE="('Fedora'|'OpenSuse'|'Red Hat')"
    
    #OSNAME=$(grep -E '^(NAME)=' /etc/os-release)
    OSNAME=$(cat /proc/version)
    
    for option in ${RPM_TYPE//|/ }; do
        if [[ "$OSNAME" == *"option"* ]]; then
            echo -e "la cadena encontro $option"
            package_format='rpm'
        fi
    done
    
    # if [[ "$OSNAME" =~ $DEB_TYPE ]]; then
    #     OS_DERIVATES="deb"
    # fi
    # if [[ "$OSNAME" =~ $RPM_TYPE ]]; then
    #     OS_DERIVATES="rpm"
    # fi

    OS_FOUND="System:  $package_format, $ARCH"
    export OS_FOUND
    echo $OS_FOUND
}