#!/bin/bash
source util.sh
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
    for file in $(allFiles $1); do
        wc -l $file
    done
}

max=$(checkOptVar $2 10)

lineCount $1 | sort -rg | head -$max
