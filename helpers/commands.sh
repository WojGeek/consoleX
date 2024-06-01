#!/bin/bash

#
#  packages installer
#


install_package () {
    
    installed=0
    pkg="$@"
    
    if [ -z "$1" ]
    then
        echo " - install_package: none arguments given"
        exit 1
    fi
    

    if [ "$PACKAGE_EXT" == 'deb' ]
    then
        
        #sudo apt install  $pkg 2>&1
        sudo $PACKAGE_MGR install  $pkg 2>&1
        installed=1
        
    elif [ "$PACKAGE_EXT" == 'rpm' ]
    then
        
        #sudo dnf install -y $pkg
        sudo $PACKAGE_MGR install -y $pkg
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
    
    if [ "$PACKAGE_EXT" == 'deb' ] ; then
        
        status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>/dev/null)"

        # Status for DEB packages not installed
        in_case_not_found_pkg=$deb_status
        
    elif [ "$PACKAGE_EXT" == 'rpm' ] ; then
        
        status="$(rpm -q  "$pkg" 2>/dev/null)"
        
        # Status for RPM packages not installed
        in_case_not_found_pkg=$rpm_status
    else
        
        echo " - Allowed $allowed_packages only,  install $pkg manually, please"
        
    fi
    
   

    if [[  "$status" =~ $in_case_not_found_pkg  ]] ; then
            # package status 

       
            pkg_found=0
            query="Failure"
            echo -e "pkg_query: $status ❎"

        else

            
            pkg_found=1
            query="Success"
          
            echo -e "pkg_query: $status ✅"

    fi

 
 
            
    echo -e "  pkg_found: $pkg_found, pkg_type: $PACKAGE_EXT, query: $query"
    
    unset $pkg

    
}

confirm_installation() {
    echo -e "\n"
    PS3="Select the choice, please: "

    pkg=$1
    items=("Install the package: $1" )

    while true; do
        select item in "${items[@]}" "Continue without installing"
        do
            case $REPLY in                                                                       
                1)                                                                               
                   echo -e "\n Complete next instructions to $item or CTRL-C to abort"                           
                   return 1                                                                    
                   ;;                                                                            
                $((${#items[@]}+1)))                                                             
                   echo "We're done!"                                                            
                   break 2                                                                       
                   ;;                                                                            
                *) echo "Ooops - unknown choice $REPLY"                                          
                break;;                                                                          
            esac                                                                                 
        done                                                                                     
    done                                                                                         
                                                                                                 
}