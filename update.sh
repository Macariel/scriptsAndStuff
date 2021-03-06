#!/usr/bin/env zsh
dir="$(dirname "$(readlink -f "$0")")"
source "$dir/util.sh"

updateRepo() {
    local type=$(echo $1 | awk '{print $1}')
    local repoDir=$(echo $1 | awk '{print $2}')
    local name=$(basename $repoDir)

    cd $repoDir
    printf "${BLUE}############################${NC}\n"
    printf "${YELLOW}Updating $name${NC}\n"
    printf "${BLUE}############################${NC}\n"
    if [ "$type" "==" "git" ]; then
        git fetch 2>&1
        git pull 2>&1
    elif [ "$type" "==" "svn" ]; then
        svn up 2>&1
    fi
    cd - >/dev/null
    printf "\n"
}

while read line; do
    updateRepo "$line"
done < $dir/.update_config
