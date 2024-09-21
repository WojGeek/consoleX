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

# Función para mostrar mensajes de depuración con un ícono de alarma
debug_message() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")  # Captura la fecha y hora actual
    local message="$1"  # Primer argumento como el mensaje
    shift  # Desplaza los argumentos a la izquierda, eliminando el primero

    # Comprueba si hay variables adicionales
    if [ "$#" -gt 0 ]; then
        echo -e "[DEBUG] [${timestamp}] 🔔 ${message} | Variables: $@"  # Muestra el mensaje y las variables pasadas
    else
        echo -e "[DEBUG] [${timestamp}] 🔔 ${message} | Sin variables adicionales."  # Mensaje sin variables
    fi
}

# for warning before complete loading
source $HELPERS/001-messages_helper.sh

#source ./helpers.sh  # Cargar el archivo de helpers
for helper in $HELPERS/*_helper.sh; do
	source "$helper"
	
    # uncomment to debug
    #ok "Loaded: $helper"
done
