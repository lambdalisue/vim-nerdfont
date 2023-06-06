#/bin/sh
ESC=$(printf '\033')
printf '\n'

terminate() {
    printf '\n'
    exit $1
}


if ! command -v jq > /dev/null ; then
    printf "${ESC}[1;31m%s  ${ESC}[1;39m%s${ESC}[m\n" '🞬' 'jq is not installed. Please install it and try again.'
    terminate 1
fi

printf "${ESC}[1;32m%s  ${ESC}[1;39m%s${ESC}[m\n\n" '✓' 'jq is installed!'


for json in $(dirname $0)/*.json ; do
    printf "${ESC}[1;39mSorting ${ESC}[0;39m%s...  ${ESC}[m" $json
    (rm $json && jq '.' --sort-keys > $json) < $json
    printf "${ESC}[1;32mDONE!${ESC}[m\n"
done

terminate 0
