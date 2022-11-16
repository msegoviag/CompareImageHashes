#!/bin/bash

# Author: Miguel Segovia Gil
# Version: 0.1
# Utilidad para la asignatura de Análisis Forense del Master FP Ciberseguridad PTA CAMPANILLAS.
# chmod +x para añadir permiso de ejecución al fichero. 
# Se necesita sudo ./CompareImageHashes.sh o root para analizar dispositivos sdxx

checkArgsAndFileExist() {

    if ! [[ -b "$pathForensicImage" || -f "$pathForensicImage" || -d "$pathForensicImage" ]]; then
        echo "El archivo $pathForensicImage no se encuentra en el sistema o no es posible procesarlo."
        return
    fi

    if ! [[ -b "$pathOriginDevice" || -f "$pathOriginDevice" || -d "$pathOriginDevice" ]]; then
        echo "El archivo $pathOriginDevice no se encuentra en el sistema o no es posible procesarlo."
        return
    fi

    compareImage
}

compareImage() {

    echo "Comparando hashes de los ficheros..."
    if cmp -s "$pathForensicImage" "$pathOriginDevice"; then

        echo "¡OK! $pathForensicImage y $pathOriginDevice son iguales"
        return
    else
        echo "$pathForensicImage y $pathOriginDevice son distintos!"
        return
    fi

}

pathForensicImage=''
pathOriginDevice=''

if ! [ $# -ne 2 ]; then
    pathForensicImage=$1
    pathOriginDevice=$2
    checkArgsAndFileExist

fi

if [ $# -eq 0 ]; then
    read -p "Introduce ruta imagen forense: " pathForensicImage
    read -p "Introduce ruta dispositivo origen: " pathOriginDevice
    checkArgsAndFileExist

fi

if (($# > 0)) && (($# < 2)) || (($# >= 3)); then
    echo "Debes introducir únicamente 2 argumentos: ./$(basename "$0") [ruta imagen] [ruta dispositivo]"
fi
