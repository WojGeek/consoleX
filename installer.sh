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

# Activar para conexiones SSH  
LINE='if [ -f ~/.bashrc ]; then source ~/.bashrc; fi'

# Verifica si la línea ya existe en .bash_profile
if ! grep -Fxq "$LINE" ~/.bash_profile; then
    # Si no existe, la añade al final del archivo
    echo "$LINE" >> ~/.bash_profile
    echo "Línea añadida a .bash_profile."
else
    echo "La línea ya existe en .bash_profile."
fi

echo -e " Re-open console to apply changes! "
echo -e " ☕ Have a great day ☘"
