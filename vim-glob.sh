#!/bin/bash

if [ -e "$pattern" ]; then
    vim "$1"
fi

matches=( *"$1"* )

if [ "${matches[0]}" = "*$1*" ]; then
    vim "$1"
    exit 0
elif [ "${#matches[@]}" -eq 1 ]; then
    vim "${matches[0]}"
    exit 0
else
    printf 'Multiple matches:\n'
    select f in "${matches[@]}"; do
        [ -n "$f" ] || { printf 'Invalid choice\n' >&2; continue; }
        vim "$f"
        break
    done
fi
