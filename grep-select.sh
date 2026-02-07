#!/bin/bash

# Usage: grep-search.sh partial_name "$(ls -ap)" "vim"

search_term=$1
options=$2
cmd=$3

matches=$(printf '%s\n' "$options" | grep -- "$search_term")
count=$(printf '%s\n' "$matches" | sed '/^$/d' | wc -l)

if [ "$count" -eq 0 ]; then
    echo "No matches for '$search_term'" >&2
elif [ "$count" -eq 1 ]; then
    eval "$cmd \"$matches\""
else
    echo "Multiple matches found:"
    mapfile -t arr <<< "$matches"
    select choice in "${arr[@]}"; do
        if [ -n "$choice" ]; then
            eval "$cmd \"$choice\""
            break
        else
            echo "Invalid selection"
        fi
    done
fi
