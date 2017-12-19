#!/usr/bin/env zsh 
thisDir=$(cd $(dirname $0);pwd)
config="$thisDir/.update_config"
source "$thisDir/"util.sh

checkRepo() {
    local searchDir=$1
    local repoType=$2
    for repo in $(find $searchDir -type d -name ".$2"); do
        local absolutePath=$(cd $(dirname $repo); pwd)
        local folderName=$(basename $absolutePath)

        # get repo status
        getStatus "$repoType";repoStatus=$? 
        local message=$(getStatusMessage $repoStatus)

        # get update config status
        local added=`grep "$absolutePath" "$config" | wc -l`
        if [ $added -eq "0" ]; then
            addedStatus="${RED}(-)${NC}"
        else
            addedStatus="${BLUE}(+)${NC}"
        fi

        # ask if it should be added
        printf "($2) $addedStatus $message${RED}Set ${NC}$folderName${RED} to auto update? (y/n): ${NC}" 
        read yn
        if [ "$yn" "==" "y" ] && [ $added -eq 0 ]; then
            echo "$2 $absolutePath" >> $config
        elif [ ! "$yn" "==" "y" ] && [ $added -gt 0 ]; then
            sed -i '\#'$absolutePath'#d' $config
        fi
    done
    wait
}

getStatus() {
    cd $absolutePath
    if [ "$1" "==" "git" ] 
    then
        getGitStatus
    elif [ "$1" "==" "svn" ]
    then
        getSvnStatus
    fi
    cd -
}

getStatusMessage() {
    if [ $1 -eq 1 ]; then
        echo "(up-to-date)\t"
    elif [ $1 -eq 2 ]; then
        echo "(behind)\t"
    elif [ $1 -eq 3 ]; then
        echo "(ahead)\t"
    elif [ $1 -eq 4 ]; then
        echo "(diverged)\t"
    elif [ $1 -eq 5 ]; then
        echo "(no upstream)\t"
    fi
}

getSvnStatus() {
    REMOTE=`svn info -r HEAD | grep -i "Last Changed Rev" | awk '{print $4}'`
    LOCAL=`svn info | grep -i "Last Changed Rev" | awk '{print $4}'`

    if [ -z "$REMOTE" ]; then
        return 5
    fi

    if [ "$REMOTE" -gt "$LOCAL" ]; then
        return 3
    elif [ "$REMOTE" -lt "$LOCAL" ]; then
        return 2
    else
        return 1
    fi
}

getGitStatus() {
    #ceol=`tput el` # terminfo clr_eol
    #echo -ne "fetching...\r"
    #`git fetch >/dev/null`
    #echo -ne "\r${ceol}"

    if REMOTE=`git rev-parse "@{u}" 2>/dev/null`; then
        LOCAL=$(git rev-parse @)
        BASE=$(git merge-base @ @{u})

        if [ $LOCAL "==" $REMOTE ]; then
            # Up-to-date
            return 1
        elif [ $LOCAL "==" $BASE ]; then
            # Need to pull
            return 2
        elif [ $REMOTE "==" $BASE ]; then
            # Need to push
            return 3
        else
            # Diverged
            return 4
        fi
    else
        # No upstream branch
        return 5
    fi
}

# check if config file exists
if [ ! -f "$config" ]; then
    touch "$config"
fi

dir=${1:-"."}
checkRepo $dir "git"
checkRepo $dir "svn"
