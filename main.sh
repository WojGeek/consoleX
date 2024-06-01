#!/bin/bash

#  Optimiza la UX en la consola de comandos
#       Bash shell
#    14.4.2024, 23h31
#
#  Se refactoriza el código de:
#  https://github.com/WojGeek/set-bash-env.git


# TODO: To enable check_NodeJS

main() {

    source "$HOME/consoleX/set_main-env.sh"
    
    #require_helpers
    if  [  $prompt_enable ] ; then
        customize_shell_prompt
    fi
    enable_alias_pkg_mgmt
    doyouwish_chrome
    announce_end_running
    #  ❎
}

main
