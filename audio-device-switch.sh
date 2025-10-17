#!/bin/bash

# Obtiene el sink por defecto actual
current_sink=$(LANG=C pactl info | awk -F': ' '/^Default Sink:/ {print $2}')
printf "'Current: ${current_sink}'\n"

# Obtiene la lista de sinks disponibles (IDs y nombres)
readarray -t sinks < <(pactl list short sinks | awk '{print $2}')

# Si hay menos de 2 sinks, salir
if [ ${#sinks[@]} -le 1 ]; then
    notify-send "Solo hay un sink de audio disponible: $current_sink"
    exit 0
fi

# Encuentra el índice del sink actual
for i in "${!sinks[@]}"; do
    if [[ "${sinks[$i]}" == "$current_sink" ]]; then
        current_index=$i
        break
    fi
done

# Calcular el siguiente sink (circular)
next_index=$(( (current_index + 1) % ${#sinks[@]} ))
next_sink="${sinks[$next_index]}"

# Cambiar el sink por defecto
pactl set-default-sink "$next_sink"

# Mover todas las reproducciones actuales al nuevo sink
for input in $(pactl list short sink-inputs | awk '{print $1}'); do
    pactl move-sink-input "$input" "$next_sink"
done

# Notificar cambio (opcional)
notify-send "Salida de audio cambiada a: ${next_sink#alsa_output.}"
