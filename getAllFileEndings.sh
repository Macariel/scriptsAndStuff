#!/bin/bash
description="This script can take up to two arguments:\n
[1]\t\t: Path to the directory which should be traversed to list all its containing file extensions.
[2](opt)\t: Minium number of occurrences a file extensions must have to appear on the list.
\t\t  The default is 1\n"
if [ $# -eq 0 ]
then
    printf "$description"
    exit
fi

if [ -z "$2" ]
then
    number=1 
else
    number=$2
fi

find $1 -name "*.*" | 
    awk -F . '{print $NF}' | 
    sort | uniq -c | sort -rg | 
    awk -v number="$number" -F " " '{if($1>=number) print $0}' 
