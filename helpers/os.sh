#!/bin/bash

set -e

detect_arch() {
    if [ "$(uname -s)" = "Darwin" ] && [ "$(uname -m)" = "x86_64" ]; then
        target="x86_64-apple-darwin"
    elif [ "$(uname -s)" = "Darwin" ] && [ "$(uname -m)" = "arm64" ]; then
        target="aarch64-apple-darwin"
    elif [ "$(uname -s)" = "Linux" ] && [ "$(uname -m)" = "x86_64" ]; then
        target="x86_64-unknown-linux-musl"
    elif [ "$(uname -s)" = "Linux" ] && [ "$(uname -m)" = "aarch64" ]; then
        target="aarch64-unknown-linux-musl"
    elif [ "$(uname -s)" = "Linux" ] && ( uname -m | grep -q -e '^arm' ); then
        target="arm-unknown-linux-gnueabihf"
    else
        echo "Unsupported OS or architecture"
        return
    fi
    echo "Detected target: $target"
}



detect_os() {
    
    MACHINETYPE="$(uname -m)";
    ARCH="${MACHINETYPE}";
    
    DEB_TYPE='(Debian|Ubuntu|Mint|Parrot)'
    RPM_TYPE='(Fedora|OpenSuse|RedHat)'
    
    #OSNAME=$(grep -E '^(NAME)=' /etc/os-release)
    OSNAME=$(cat /proc/version)
    
    OS_FOUND="OS Found:  $OSNAME, $ARCH"

    export OS_FOUND
    
    if [[ $OSNAME =~ $DEB_TYPE ]]; then
        OS_DERIVATES="deb"
    fi
    if [[ $OSNAME =~ $RPM_TYPE ]]; then
        OS_DERIVATES="rpm"
    fi
}