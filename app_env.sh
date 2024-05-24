#!/bin/sh

# ruta del clone git
CLONEDAPP_DIR="$HOME/consoleX"       ##  DO NOT CHANGE

# Components
helpers=$CLONEDAPP_DIR/helpers.sh

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