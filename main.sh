#!/bin/bash

#  Optimiza la UX en la consola de comandos
#       Bash shell
#    14.4.2024, 23h31
#
#  Se refactoriza el código de:
#  https://github.com/WojGeek/set-bash-env.git



# # En Produccion o Desarrollo
# IS_DEVELOPING=1

# set_main_environment() {
#     # default location after  cloning
#     CLONEDAPP_DIR="$HOME/consoleX"
#     source $CLONEDAPP_DIR/set_main-env.sh
# }

# require_helpers(){
#    source $CLONEDAPP_DIR/helpers.sh
# }

# announce_end_running() {
#     if [ ! $prompt_enable ] ; then
#         echo -e "\nPlease close and re-open your console, to watch effects.\n"
#     fi 
# }


# TODO: To enable check_NodeJS

main() {
    #echo -e "Simply do more with fewer keystrokes." 

    source "$HOME/consoleX/set_main-env.sh"
    
    require_helpers
    # TODO:  revisar show_info
    if  [  $prompt_enable ] ; then
        customize_shell_prompt
    fi
    enable_alias_pkg_mgmt
    doyouwish_chrome
    announce_end_running
}

main
