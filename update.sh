#!/usr/bin/env bash
updateRepo() {
    local type=$(echo $1 | awk '{print $1}')
    local repoDir=$(echo $1 | awk '{print $2}')
    local name=$(basename $repoDir)

    cd $repoDir >/dev/null
    printf "Updating $name... "
    if [ "$type" == "git" ]; then
        git fetch >/dev/null
        git pull >/dev/null 2>&1
    elif [ "$type" == "svn" ]; then
        svn up >/dev/null
    fi
    echo "done"
    cd - >/dev/null
}

while read line; do
    updateRepo "$line"
done <.update_config
