#!/bin/bash

# Identify operating system as well the package manager
#  1.06.20.2024, 14h06

# Detectar el sistema operativo
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    OS=$(lsb_release -s -i)
    VER=$(lsb_release -s -r)
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    OS=Debian
    VER=$(cat /etc/debian_version)
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

# Determinar el gestor de paquetes
case "$OS" in
    debian|ubuntu|linuxmint|parrotos)
        PACKAGE_MGR="apt"
        PACKAGE_EXT="deb"
        ;;
    fedora|rhel|centos)
        if command -v yum &> /dev/null; then
            PACKAGE_MGR="yum"
            PACKAGE_EXT="rpm"
        else
            PACKAGE_MGR="dnf"
            PACKAGE_EXT="rpm"
        fi
        ;;
    opensuse-leap|opensuse-tumbleweed)
        PACKAGE_MGR="zypper"
        PACKAGE_EXT="rpm"
        ;;
    *)
        PACKAGE_MGR="unknown"
        PACKAGE_EXT="unknown"
        ;;
esac



if grep -q "^OS=" console.env; then
    sed -i "s/OS=.*/OS=$OS/" console.env
else
    echo "OS=$OS" >> console.env
fi

if grep -q "^VER=" console.env; then
    sed -i "s/VER=.*/VER=$VER/" console.env
else
    echo "VER=$VER" >> console.env
fi

if grep -q "^PACKAGE_MGR=" console.env; then
    sed -i "s/PACKAGE_MGR=.*/PACKAGE_MGR=$PACKAGE_MGR/" console.env
else
    echo "PACKAGE_MGR=$PACKAGE_MGR" >> console.env
fi

if grep -q "^PACKAGE_EXT=" console.env; then
    sed -i "s/PACKAGE_EXT=.*/PACKAGE_EXT=$PACKAGE_EXT/" console.env
else
    echo "PACKAGE_EXT=$PACKAGE_EXT" >> console.env
fi

echo -e "Identify OS and package format ✅"