#!/bin/bash

shopt -s dotglob

if [ -e "$pattern" ]; then
    vim "$1"
fi

matches=( *"$1"* )

if [ "${matches[0]}" = "*$1*" ]; then
    echo No match found
    exit 1
elif [ "${#matches[@]}" -eq 1 ]; then
    vim "${matches[0]}"
    exit 0
else
    echo Multiple matches:
    select f in "${matches[@]}"; do
        [ -n "$f" ] || { echo Invalid choice >&2; continue; }
        vim "$f"
        break
    done
fi
