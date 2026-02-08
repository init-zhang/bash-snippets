#!/bin/bash

m=$(echo "$2" | grep -- "$1")
c=$(echo "$m" | grep -c .)

if [ "$c" -eq 0 ]; then
    echo "No matches for '$1'" >&2
elif [ "$c" -eq 1 ]; then
    eval "$3 \"$m\""
else
    echo "Multiple matches found:"
    mapfile -t a <<< "$m"
    select c in "${a[@]}"; do
        if [ -n "$c" ]; then
            eval "$3 \"$c\""
            break
        fi
        echo "Invalid selection"
    done
fi
