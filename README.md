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
