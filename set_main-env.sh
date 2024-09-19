#!/bin/bash


# Main pathfiles like has been cloned
CLONEDAPP_DIR="$HOME/consoleX"       		## For the sake of this app, please don't change it.

helpers=$CLONEDAPP_DIR/helpers.sh		# Components

ENVIRONMENT="$CLONEDAPP_DIR/console.env"  	## For the sake of this app, please don't change it.
source $ENVIRONMENT

load_helpers() {
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




#TODO:  Create environment file if not exist
# file: console.env

# En Produccion o Desarrollo
IS_DEVELOPING=1


announce_end_running() {
    if [ ! $prompt_enable ] ; then
        echo -e "\nPlease close and re-open your console, to apply changes.\n"
    fi 
}

echo -e "✅ Helpers/Components"
load_helpers



update_prompt_status() {
    # Bash prompt
    if grep -q "^prompt_enable=" $ENVIRONMENT; then
        sed -i "s/prompt_enable=.*/prompt_enable='false'/" $ENVIRONMENT
    else
        echo "# Require to install Bash prompt by Powerline" >> $ENVIRONMENT
        echo "prompt_enable=$prompt_enable" >> $ENVIRONMENT
    fi
}

echo -e "✅ Environment updated"
update_prompt_status
source $ENVIRONMENT

