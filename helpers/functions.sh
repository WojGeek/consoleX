#!/bin/sh

enable_ux() {
    echo -e " • UX Enabled "
    # if [ -d $SYSTEMDIRECTORY ]; then
    #     echo -e $SYSTEMDIRECTORY
    
    # fi
}



detect_os() {
    
    MACHINETYPE="$(uname -m)";
    ARCH="${MACHINETYPE}";
    
    DEB_TYPE='(Debian|Ubuntu|Mint|Parrot)'
    RPM_TYPE='(Fedora|OpenSuse|RedHat)'
    
    OSNAME=$(grep -E '^(NAME)=' /etc/os-release)
    OS_FOUND="OS Found:  $OSNAME, $ARCH"
    export OS_FOUND
    
    if [[ $OSNAME =~ $DEB_TYPE ]]; then
        OS_DERIVATES="deb"
    fi
    if [[ $OSNAME =~ $RPM_TYPE ]]; then
        OS_DERIVATES="rpm"
    fi
}

ChooseDistro() {
    detect_os
    echo -e " • $OS_FOUND"
    case $OS_DERIVATES in
        "rpm")
            
            if [ `rpm -q $1` ]; then
                echo -e "$OK Powerline installed"
            else
                echo -e "Powerline Prompt not installed for $OSNAME"
                # TODO: install_package powerline powerline-fonts
            fi
        ;;
        "deb")
            #    if [  `dpkg -s $1` ]; then
            if [ -f  `which powerline` ]; then
                echo -e "$OK Powerline installed"
            else
                echo -e "Powerline Prompt not installed for $OSNAME"
                #TODO: install_package powerline fonts-powerline
            fi
            
        ;;
        *)
            echo -e "\nNo se pude identificar el sistema operativo"
        ;;
    esac
}




# identificar OS
check_NodeJS() {
    
    found_nodejs="null"
    
    VERSIONSNODEJS='(v18|v16|v15|v14)'
    
    if ! node -v  &> /dev/null
    then
        echo -e "Node JS no se encontró instalado"
        found_nodejs="false"
        
        return 0
    else
        NODEVERSION="$(node -v)";
        NODEJS_VERSION_FOUND="NODE JS $NODEVERSION"
        echo -e " • Node JS — server-side JavaScript runtime $NODEVERSION "
    fi
    
    
    if [[ $NODEVERSION =~ $VERSIONSNODEJS ]]; then
        found_nodejs="true"
        # echo -e " Encontrado $NODEJS_VERSION_FOUND"
    fi
    
    # npm manager
    if ! npm -v  &> /dev/null
    then
        echo -e "npm  no se encontró instalado"
        found_nodejs="false"
        exit
    else
        NPMVERSION="$(npm -v)";
        echo -e " • npm - javascript package manager installed $NPMVERSION"
    fi
    
}
