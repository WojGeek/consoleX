#!/bin/bash

# functions_wrapper.sh



# for warning before complete loading
#source $HELPERS/001-messages_helper.sh

#source ./helpers.sh  # Cargar el archivo de helpers
for helper in $HELPERS/*_helper.sh; do
	source "$helper"
	
    # uncomment to debug
     #check_ok " $helper"
done
