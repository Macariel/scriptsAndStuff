#!/usr/bin/env bash
dir="$(dirname "$(readlink -f "$0")")"
source "$dir/util.sh"

default_results=10
description="This script can take up to two arguments:\n
[1]\t\t: Path to the directory which should be traversed 
[2](opt)\t: Maximum number of results.
\t\t  The default is $default_results\n"
if [ $# -lt 1 ]
then
    printf "$description"
    exit
fi

lineCount () {
    allFiles $1 | while read file; do
    lines=$(printf '%-5s' $(wc -l "$file" | awk '{print $1}'))
    bytes=$(stat --printf="%s" "$file" | numfmt --to=iec-i --suffix=B --padding=7)
    fileName=$(printf '%-25s' $(basename "$file"))
    echo "$lines $bytes   $fileName $file"
    done
}

max=${2:-$default_results}
lineCount $1 | sort -rg | head -$max
