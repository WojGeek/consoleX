#!/bin/bash

# Identify operating system as well the package manager
#  1.06.20.2024, 14h06


# ChangesLogs
#	19.09.2024	- Rocky Linux added at OS list


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
    debian|ubuntu|linuxmint|parrots)
        PACKAGE_MGR="apt"
        PACKAGE_EXT="deb"
        ;;
    fedora|rhel|centos|rocky)
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



if grep -q "^OS=" $ENVIRONMENT; then
    sed -i "s/OS=.*/OS=$OS/" $ENVIRONMENT
else
    echo "OS=$OS" >> $ENVIRONMENT
fi

if grep -q "^VER=" $ENVIRONMENT; then
    sed -i "s/VER=.*/VER=$VER/" $ENVIRONMENT
else
    echo "VER=$VER" >> $ENVIRONMENT
fi

if grep -q "^PACKAGE_MGR=" $ENVIRONMENT; then
    sed -i "s/PACKAGE_MGR=.*/PACKAGE_MGR=$PACKAGE_MGR/" $ENVIRONMENT
else
    echo "PACKAGE_MGR=$PACKAGE_MGR" >> $ENVIRONMENT
fi

if grep -q "^PACKAGE_EXT=" $ENVIRONMENT; then
    sed -i "s/PACKAGE_EXT=.*/PACKAGE_EXT=$PACKAGE_EXT/" $ENVIRONMENT
else
    echo "PACKAGE_EXT=$PACKAGE_EXT" >> $ENVIRONMENT
fi

echo -e "✅ OS/Package identified: $OS-$VER/$PACKAGE_EXT"
