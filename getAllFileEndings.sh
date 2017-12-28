#!/usr/bin/env bash
source "$(dirname $0)/"util.sh
description="This script can take up to two arguments:\n
[1]\t\t: Path to the directory for which all file extensions should be listed.
[2](opt)\t: Maximum number of results.
\t\t  The default is 1\n"
if [ $# -eq 0 ]
then
    printf "$description"
    exit
fi

dir=$1
max=${2:-10}
allFiles $1 |
    grep "\." |
    awk -F . '{print $NF}' |
    sort |
    uniq -c |
    sort -rg |
    head -$max
