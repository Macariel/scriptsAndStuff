# All CPP file endings
findCPP=$(echo "-name=*."{cpp,cc,c,h,hh,hpp,cxx,hxx,inl,inc,pc})

# Returns all files with extensions and excludes dot-files
allFiles() {
    find $1 -type f -not -path '*/\.*' $(echo $findCPP)
}

# Checks if the first given variable is set if not it returs the second one
# checkvar $1 $2
# If the first one is empty it just ignores it as an input
checkOptVar() {
   echo $1
}
