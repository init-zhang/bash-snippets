function f() {
    eval "function ${1}() {
        $2
    }"
}
