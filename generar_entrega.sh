#!/usr/bin/env bash

# --- Configuration ---
DEST="$HOME/Luis/src/$(basename $PWD)"
COMMIT=$(git rev-parse HEAD)

if [ -z "$COMMIT" ]; then
    echo "Not a git repository"
    exit 1
fi

# --- Clean destination ---
rm -rf "$DEST"
mkdir -p "$DEST" || exit 1

# --- Export commit exactly as committed ---
git archive "$COMMIT" | tar -x -C "$DEST"

if [ $? -ne 0 ]; then
    echo "Export failed"
    exit 1
fi

echo "Entrega generada desde commit $COMMIT en $DEST"
