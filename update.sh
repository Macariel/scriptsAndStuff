#!/usr/bin/env bash
source "$(dirname $0)/"util.sh

checkRepo() {
    for repo in $(find $1 -type d -name ".$2"); do
        clear
        local dir=$(dirname $repo)
        printf "($2) ${RED}Update \"$dir\"(y/n)?: ${NC}"
        read yn
        if [ "$yn" == "y" ];
        then
            cd $dir
            updateRepo $2
            cd -
            read
        fi
    done
}

updateRepo() {
    if [ "$1" == "git" ]
    then
        git pull
    elif [ "$1" == "svn" ]
    then
        svn up
    fi
}

dir=${1:-"."}
checkRepo $dir "git"
checkRepo $dir "svn"
