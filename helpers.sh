#!/bin/bash

# Components
helpers=$CLONEDAPP_DIR/helpers

 # verify app directory before installing at /opt
# TODO:source $helpers/opt.sh
# TODO: check_first_install



source $helpers/display.sh
source $helpers/functions.sh
source $helpers/commands.sh
source $helpers/prompt.sh
source $helpers/chrome.sh
source $helpers/systemd.sh
source $helpers/apt_aliases.sh
source $helpers/dnfyum_aliases.sh


# identify Operating system and package manager
source $helpers/detect_os_pkgformat.sh


# Editor vim
#source $helpers/vim.sh

echo -e "✅ Helpers/Components"
