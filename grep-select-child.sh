#!/bin/bash

# Assumes `grep-select` is a valid command.
# The loop can alternatively be sourced as a function.

for path; do
    grep-select "$path" "$(ls -ap)" "cd"
done
