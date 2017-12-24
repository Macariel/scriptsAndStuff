# All CPP file endings
# We need the fist echo because one definite option before the -or is needed, otherwise it
# will just look through every file regardless of the suggested file endings
cppFiles=$(echo "-name *.h";echo "-o -name *."{cpp,cc,c,hh,hpp,cxx,hxx,inl,inc,pc})
javaFiles=$(echo "-name *.java")

# Returns all files with extensions and excludes dot-files
# The second parameter can be one of the language-specific file endings above
allFiles() {
    local dir=${1:-"."}
    find $(cd "$dir"; pwd) -type f -not -path "*/\.*" $2
}

# Color Options
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
