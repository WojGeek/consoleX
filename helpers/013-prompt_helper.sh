#!/bin/bash

#
#  Activa el prompt basado en 'powerline'
#

#source $ENVIRONMENT


update_prompt_status() {
    # Bash prompt
    if grep -q "^prompt_enable=" $ENVIRONMENT; then
        sed -i "s/prompt_enable=.*/prompt_enable='false'/" $ENVIRONMENT
    else
        echo "# Require to install Bash prompt by Powerline" >> $ENVIRONMENT
        echo "prompt_enable=$prompt_enable" >> $ENVIRONMENT
    fi
}

set_prompt() {
    
    if [ "$PACKAGE_EXT" == 'deb' ] ; then
            if [ -f  "/usr/share/powerline/bindings/bash/powerline.sh" ]; then
                source /usr/share/powerline/bindings/bash/powerline.sh
                prompt_enable="true"
                update_prompt_status
            else
                prompt_enable="false"
                update_prompt_status
            fi
    elif [ "$PACKAGE_EXT" == 'rpm' ] ; then
            source /usr/share/powerline/bash/powerline.sh
            prompt_enable="true"
            update_prompt_status
            
    else 
         echo " - Unknown installer for this system: $1"
         prompt_enable="false"
         update_prompt_status

    fi
}

install_according_distro() {
        echo -e " - Install powerline for \"$PACKAGE_EXT\" derivatives systems "

        if [ $PACKAGE_EXT == "rpm" ]; then
            # install powerline for Fedora
            install_package powerline powerline-fonts  
            #install_package powerline-fonts
        fi
        if [ $PACKAGE_EXT == "deb" ]; then
            # install powerline for Debian/Ubuntu
            install_package powerline fonts-powerline powerline-gitstatus
            #install_package fonts-powerline # install powerline for Debian
        fi

}

enable_powerline_prompt() {

   if ! command -v powerline-daemon &> /dev/null 
   then 
       echo "Powerline-daemon is required but it is not installed"

       confirm_installation $pkg
        if [ $? -eq 1 ] ; then
            # Accepted
            
            install_according_distro
        fi
        
        
   else
        powerline-daemon -q
        POWERLINE_BASH_CONTINUATION=1
        POWERLINE_BASH_SELECT=1
   fi
    
}

prompt_main_startup () {
    
    pkg="powerline"

    pkg_query $pkg

    if [  $? -eq 0 ] && [  "$pkg_found" == 0 ]; then
        
        ##  Give user options to install the packages or not..
        confirm_installation $pkg
        if [ $? -eq 1 ] ; then
            # Accepted
            
            install_according_distro
        fi
        
    fi
}


customize_shell_prompt() {
    #echo -e " - Customize the shell prompt"
    prompt_enable=""
    prompt_main_startup
    if [ "$pkg_found" == 1 ] ; then
        set_prompt
        enable_powerline_prompt
    fi
    
}
