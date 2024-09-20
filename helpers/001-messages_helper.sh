#!/bin/bash

# funciones/mensajes.sh

# Función para desplegar mensajes con fecha y hora
function show_message() {
    local mensaje="$1"  # Captura el argumento pasado a la función
    local fecha_hora=$(date '+%Y-%m-%d %H:%M:%S')  # Obtiene la fecha y hora actual
    echo "[$fecha_hora] $mensaje  "  # Muestra la fecha y hora junto al mensaje
}

function catch_error() {
    local error_code="$1"
    local error_message="$2"
    show_message "Error: $error_message"
    return "$error_code"  # Salir con el código de error

}


