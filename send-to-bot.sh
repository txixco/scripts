#!/bin/bash

TOKEN="7642642794:AAH1wvbE46R5lPxcZVkP-Xb8c3NF-u6y1FA"
CHAT_ID="6717124404"
MENSAJE="Actualización cron-apt completada"
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
    -d chat_id=$CHAT_ID \
    -d text="$MENSAJE"

