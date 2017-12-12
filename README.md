# Script Collection
A place to gather all the small scripts I used. 
They are in no way polished or bug free, just some quick commands hacked together for a simple task.  
`[param]` is a necessary parameter, whereas `(param)` indicates an optional one.

- `getAllFileEndings [directory] (min_occurrences=1)`
Traverses over a given directory, gathers all file extensions and sums their occurrences up in a small compact list
- `getBiggestFiles [directory] (number_of_results=10)`
Traverses over a given directory and list the ten (default vaule) biggest files
- `update (directory=".")`
Checks if any subdirectories of the given directory or the current one are either `svn` or `git`  
and then prompts if you wanna update the

# Commands
Just some terminal commands which might come in use.

```sh
grep -oR "--include=*."{gs,gsx,gsp} -P "[\W]Date[\W]" | wc -l
```
Counts the number of occurrences `Date` was enclosed by two non-word characters. Usefull if you want to roughly 
count the number of times a class is actually used as a type.  
`-o`: Only output the matches not the whole line; every match is now in its own line even though there might be mulitple matches per line
