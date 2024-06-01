#!/bin/bash

#
#  Activa el prompt basado en 'powerline'
#


set_prompt() {
    # Powerline prompt

  
    #echo -e " - Enable Powerline Prompt here"

    detect_os
    if [ "$OS_DERIVATES" == 'deb' ] ; then
            if [ -f  "/usr/share/powerline/bindings/bash/powerline.sh" ]; then
                source /usr/share/powerline/bindings/bash/powerline.sh
                prompt_enable="true"
            else
                prompt_enable="false"
            fi
    elif [ "$OS_DERIVATES" == 'rpm' ] ; then
        
            
            source /usr/share/powerline/bash/powerline.sh
            prompt_enable="true"
    else 
         echo " - Check package installer for this platform: $1"
         prompt_enable="false"
    fi
    
 
    
    # if [  $prompt_enable == "false" ]; then
    #     echo -e "\tThere was no success enabling the prompt "
    # fi
    
}

install_according_distro() {

        detect_os

        echo -e " - Install powerline for \"$OS_DERIVATES\" derivatives systems "

        if [ $OS_DERIVATES == "rpm" ]; then
            # install powerline for Fedora
            install_package powerline powerline-fonts  powerline-gitstatus 
            #install_package powerline-fonts
        fi
        if [ $OS_DERIVATES == "deb" ]; then
            # install powerline for Debian/Ubuntu
            install_package powerline fonts-powerline powerline-gitstatus
            #install_package fonts-powerline # install powerline for Debian
        fi

}

enable_powerline_prompt() {

   if ! command -v powerline-daemon &> /dev/null 
   then 
    echo "- It require powerline-daemon but it's not installed.  Aborting."
    install_according_distro
    return
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
    prompt_main_startup
    if [ "$pkg_found" == 1 ] ; then
        set_prompt
        enable_powerline_prompt
       
    fi
    
}