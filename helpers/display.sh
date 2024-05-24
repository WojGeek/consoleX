#!/bin/sh

show_info() {
    # Visualizo las ubicaciones relacionadas
    # echo -e " • Cloned Git: "$CLONED_GIT_REPOSITORY
    echo " • Target Dir: "$SYSTEMDIRECTORY
    #echo -e " • Main code: $MAIN_"
    if [ $IS_DEVELOPING = 1 ]; then
        echo -e " • Status: En desarrollo"
    fi
}
