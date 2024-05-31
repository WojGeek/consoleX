#!/bin/bash

#
#  packages installer
#


install_package () {
    
    installed=0
    pkg="$@"
    
    if [ -z "$1" ]
    then
        echo " - install_package: no hay argumentos"
        return
    fi
    
    detect_os
    if [ "$OS_DERIVATES" == 'deb' ]
    then
        
        #echo -e "\t *** sudo apt install -y  $pkg "
        sudo apt install  $pkg 2>&1
        installed=1
        
    elif [ "$OS_DERIVATES" == 'rpm' ]
    then
        
        #echo " - sudo yum install -y $pkg "
        sudo dnf install -y $pkg
        installed=0
        
    else
        echo " - Haga una instalación manual de $1"
        installed=0
    fi
    
}


pkg_query() {
    # query is package is already installed
    

    local rpm_status="not installed"
    local deb_status="TODO: averiguar y ajustar aqui"
    local query="null"
 

    pkg=$1

    if [ -z "$pkg" ]
    # [  -z "$pkg" ] ||  
    then
        echo " - pkg_query: no arguments given for query"
        return
    fi
    
    detect_os
    if [ "$OS_DERIVATES" == 'deb' ] ; then
        
        status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>/dev/null)"

        # Status for DEB packages not installed
        in_case_not_found_pkg=$deb_status
        
    elif [ "$OS_DERIVATES" == 'rpm' ] ; then
        
        status="$(rpm -q  "$pkg" 2>/dev/null)"
        
        # Status for RPM packages not installed
        in_case_not_found_pkg=$rpm_status
    else
        
        echo " - Allowed $allowed_packages only,  install $pkg manually, please"
        
    fi
    
   

    echo -e "- pkg_query: $status"
    if [[  "$status" =~ $in_case_not_found_pkg  ]] ; then
            # package status 

       
            pkg_found=0
            query="Failure"
          

        else

            
            pkg_found=1
            query="Success"
          

    fi

 
 
            
    echo -e "  pkg_found: $pkg_found, pkg_type: $OS_DERIVATES, query: $query"
    
    # TODO: remover , status: $in_case_not_found_pkg    "
    
 
    unset $pkg

    
}