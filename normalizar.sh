#! /usr/bin/env bash

for dir in */; do
    dir=${dir%*/}
    cd "$dir"

    for file in *; do
        ext=${file#${file%*.avi}}

        # f=$(printf "%s\n" "$file" | grep -oE 'S[0-9]{2}E[0-9]{3,4}.avi')
        # [[ -n $f ]] && mv -- "$file" "$f"

        # n=$(printf "%s\n" "$file" | grep -oE '[0-9]{3,4}')
        # [[ -n $n ]] && echo mv -- "$file" "${dir}E${n}${ext}"

        n=$(printf "%s\n" "$file" | grep -oE '[0-9]{2}x[0-9]{2}' | awk -Fx '{print $1$2}')
        [[ -n $n ]] && mv -- "$file" "${dir}E${n}${ext}"
    done

    cd -
done
