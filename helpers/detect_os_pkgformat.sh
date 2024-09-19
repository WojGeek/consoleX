#!/bin/bash

# Identify operating system as well the package manager
#  1.06.20.2024, 14h06


# ChangesLogs
#	19.09.2024	- Rocky Linux added at OS list
#			- set  path for console.env'

# console env path
OSENVPATH="$CLONEDAPP_DIR/console.env"

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



if grep -q "^OS=" $OSENVPATH; then
    sed -i "s/OS=.*/OS=$OS/" $OSENVPATH
else
    echo "OS=$OS" >> $OSENVPATH
fi

if grep -q "^VER=" $OSENVPATH; then
    sed -i "s/VER=.*/VER=$VER/" $OSENVPATH
else
    echo "VER=$VER" >> $OSENVPATH
fi

if grep -q "^PACKAGE_MGR=" $OSENVPATH; then
    sed -i "s/PACKAGE_MGR=.*/PACKAGE_MGR=$PACKAGE_MGR/" $OSENVPATH
else
    echo "PACKAGE_MGR=$PACKAGE_MGR" >> $OSENVPATH
fi

if grep -q "^PACKAGE_EXT=" $OSENVPATH; then
    sed -i "s/PACKAGE_EXT=.*/PACKAGE_EXT=$PACKAGE_EXT/" $OSENVPATH
else
    echo "PACKAGE_EXT=$PACKAGE_EXT" >> $OSENVPATH
fi

echo -e "OS and package format: $OS-$VER ($PACKAGE_EXT) ✅"
