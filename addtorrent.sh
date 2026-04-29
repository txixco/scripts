#! /usr/bin/env bash

set -euo pipefail

# Some constants for errors
# E_GENERAL=1
E_USE=2

# Validate the arguments
if [[ $# -ne 2 ]]; then
    printf "ERROR: Se deben especificar la URL fuente y el directorio destino\n"
    printf "\t%s URL DESTINO\n" "${0##*/}"
    exit $E_USE
fi

url="$1"
target="$2"

if [[ $url != http?(s):* ]]; then
    printf "ERROR: La url '%s' parece no ser válida, verifíquelo\n" "$url"
    printf "\t%s URL DESTINO\n" "${0##*/}"
    exit $E_USE
fi

# Prepare the needed parts
mkdir -p "$target"

rest="${url#*://}"     # host/path
proto="${url%%://*}"   # scheme
host="${rest%%/*}"     # host
base="$proto://$host"

: "${TRANSMISSION_AUTH:?Set TRANSMISSION_AUTH=user:password}"

curl -s "$url" \
| awk -F'"' '/\.torrent/ { print "'"$base"'" $2 }' \
| xargs -n1 transmission-remote -n "$TRANSMISSION_AUTH" -a -w "$target"

exit 0
