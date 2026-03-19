#!/usr/bin/env bash

DIR_FACTURAS="$HOME/Documentos/facturas"

if [[ $# -lt 3 ]]; then
    printf "Uso: %s SERVICIO CASA ARCHIVO\n" "$0"
    exit 1
fi

servicio="$1"
casa="$2"
archivo="$3"

if [[ ! -d "$DIR_FACTURAS" ]]; then
    printf "No existe el directorio %s\n" "$DIR_FACTURAS"
    exit 1
fi

fileName=$(date +"${servicio}-%Y%m%d-${casa}.pdf")

#printf "mv %s %s\n" "$archivo" "$DIR_FACTURAS/$servicio/$casa/$fileName"
mv "$archivo" "$DIR_FACTURAS/$servicio/$casa/$fileName"
