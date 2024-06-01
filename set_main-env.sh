#!/bin/bash

# ruta del clone git
CLONEDAPP_DIR="$HOME/consoleX"       ##  DO NOT CHANGE

load_helpers() {
    # Components
    helpers=$CLONEDAPP_DIR/helpers.sh
    source $CLONEDAPP_DIR/helpers.sh

}


# target dir  
SYSTEMDIRECTORY="/opt"

# script principal
#MAIN_="$SYSTEMDIRECTORY/$CLONEDREPOSITORY/main.sh"

# Package query results
pkg_found=0

#  allowed packages for this app 
allowed_packages="(deb|rpm)"

# prompt enabled
prompt_enable="false"


# Environment console file
ENVIRONMENT=$CLONEDAPP_DIR/console.env

# get from environment status about installing Google Chrome 

source $ENVIRONMENT

#TODO:  Create environment file if not exist
# file: env

# En Produccion o Desarrollo
IS_DEVELOPING=1


announce_end_running() {
    if [ ! $prompt_enable ] ; then
        echo -e "\nPlease close and re-open your console, to watch effects.\n"
    fi 
}

echo -e "Main environment loaded ✅"
load_helpers




