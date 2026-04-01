# Bash Snippets

Repo for commands and scripts related to bash

## ANSI Colors

```bash
function colors() {
    echo -e "\033[0m NC (No color)"
    echo -e "\033[0;30m BLACK  \033[1;30m LIGHT_BLACK"
    echo -e "\033[0;31m RED    \033[1;31m LIGHT_RED"
    echo -e "\033[0;32m GREEN  \033[1;32m LIGHT_GREEN"
    echo -e "\033[0;33m YELLOW \033[1;33m LIGHT_YELLOW"
    echo -e "\033[0;34m BLUE   \033[1;34m LIGHT_BLUE"
    echo -e "\033[0;35m PURPLE \033[1;35m LIGHT_PURPLE"
    echo -e "\033[0;36m CYAN   \033[1;36m LIGHT_CYAN"
    echo -e "\033[0;37m WHITE  \033[1;37m LIGHT_WHITE"
}
```

## Timer

```bash
function timer() {
    echo "Started $1 timer at $(date +%T)"
    sleep $1
    echo "$1 timer over at $(date +%T)"
    notify-send -u critical "$1 timer over"
}

alias 5m='timer 5m'
alias 10m='timer 10m'
alias 15m='timer 15m'
alias 20m='timer 20m'
alias 30m='timer 30m'
```

## Minute Clock

```bash
alias clock='date +%T; sleep $((60 - $(date +%-S))); while true; do date +%T; sleep 1m; done'
```

Waits until the next full minute before ticking

Breakdown:

```bash
date +%T
sleep $((60 - $(date +%-S)))
while true; do
  date +%T
  sleep 1m
done
```

## To Hyphen

```bash
function to-hyphen() {
    title=''
    for arg in "$@"; do title+="${arg,,}-"; done
    echo "${title%?}"
}
```

Usage:

```
$ to-hyphen Hello World
hello-world
$ to-hyphen Does NOT remove punctuation, be wary!
does-not-remove-punctuation,-be-wary!
$ to-hyphen A MACHINE BUILT TO END WAR IS ALWAYS A MACHINE BUILT TO CONTINUE WAR
a-machine-built-to-end-war-is-always-a-machine-built-to-continue-war
```

Pipe `$@` into `grep -o '\w*'` to remove punctuation

## Swap Caps Lock and Esc

X server: `setxkbmap -option caps:swapescape`

## Directory MOTD

```bash
function cdmotd() {
    cd $@
    [[ -x .motd ]] && ./.motd
}
```

## Power

```bash
function power() {
    if [[ -n "$1" ]]; then
        powerprofilesctl set "$1"
    else
        profile="$(powerprofilesctl | awk 'match($0,/^.{2}(\S*):/,m) {print m[1]}' | dmenu -l 3 -p "$(powerprofilesctl get)")"
        [[ -n $profile ]] && powerprofilesctl set "$profile"
    fi
}
```

## Files

### vim-glob.sh

`vim-glob.sh file`

Checks if file exists first, if not, it will expand the pattern `*file*` to find a file

On multiple matches, it prompts the user to pick a file using `select`

The pattern matching and expansion is referred to as glob

### grep-select.sh

Greps $1 on $2, and passes the match to $3

If there are multiple matches, user will be prompted to select a match using `select`

All arguments should be enclosed in `"` to ensure they stay as a single argument

```bash
grep-select.sh "pattern" "$(ls -ap)" "cd"
function cd-grep() {
    grep-select.sh "$1" "$(ls -ap)" "cd"
}
```

### grep-select-min.sh

Minimised version of `grep-select`

### grep-select-onetime.sh

`grep-select` but can be pasted into a Bash session for one session use

Includes wrapper functions for `cd`, `less`, and `vim`

### grep-select-child.sh

`cd` wrapper function that calls `grep-select` for each provided argument

Allows for traversal of subdirectories in one command

### quick-function.sh

Creates a function where `$1` is the function name and `$2` is the function code

Can be used for aliases with arguments
