trim() {
    local ORIGIN=$1
    local CHAR=$2
    CHAR=${CHAR:- }
    local REGEXR="s/${CHAR}*\$//g"
    local REGEXL="s/^${CHAR}*//g"
    echo $ORIGIN | sed "$REGEXL" | sed "$REGEXR"
}
