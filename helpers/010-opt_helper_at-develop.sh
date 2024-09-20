#!/bin/sh

#
#  move the cloned git to /opt/optimize-ux-console
#     Object: Keep clean the $HOME and avoid confusing with.
#

check_clone_exist() {
    if [ ! -d $APPDIR ]; then
        echo -e " • No fue encontrado 'consoleX' "
        Clone_using_the_webURL
        return 0
    fi
    return 1
}

Clone_using_the_webURL() {
    echo -e "\tClonar usando la URL Web, desde el repositorio https://github.com/WojGeek"
    
}

check_first_install() {
    
    # 1. comprobar que fue descargado los scripts
    check_clone_exist
    if [[ $? = 1 ]]; then
        echo -e " • Cloned Web URL: "$APPDIR
        
    else
        Clone_using_the_webURL
        exit
    fi
    
}



# 2. Mover a /opt


