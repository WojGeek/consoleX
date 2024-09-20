#!/bin/bash

# functions_wrapper.sh



function show_message_with_prefix() {
    show_message "$1"
}

# función simplificada de echo con -e
function e() {
    echo -e " $@"
}

function ok() {
    echo -e "✅ $@"
}

# for warning before complete loading
source $HELPERS/001-messages_helper.sh

#source ./helpers.sh  # Cargar el archivo de helpers
for helper in $HELPERS/*_helper.sh; do
	source "$helper"
	
    # uncomment to debug
    #ok "Loaded: $helper"
done
