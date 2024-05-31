#!/bin/bash

enable_in_shell() {
    file=$1
    {
        
        echo '# ' >> ~/$file
        echo '#  Added by consoleX (https://github.com/WojGeek/consoleX.git   '
        echo 'source $HOME/consoleX/main.sh'
        echo ' '
        
    } >> ~/$file
}

enable_in_shell '.bashrc'
enable_in_shell '.profile'
enable_in_shell '.bash_profile'



echo -e " - Restaure una nueva consola"