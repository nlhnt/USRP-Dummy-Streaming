#!/bin/sh

# .gitattributes
# Changes are isolated to this repo, only changed on .git/info/attributes
# *.vi difftool=lvdiff
# *.ctl difftool=lvdiff

# .gitconfig
# Changes are isolated to this repo all commands prefaced with --local
# [diff]
#     tool = lvdiff
# [difftool "lvdiff"]
#     cmd = $GIT_WORK_TREE/LVCompareWrapper.sh $LOCAL $REMOTE $BASE $MERGED

# sed RegEx to replace / by \ in Path
PATHFIX='s/\//\\/g'

# sed RegEx to replace trailing ./ with \
TRAILFIX='s/^.\//\\/'

# Remove ending / or \
ENDFIX='s/[\\/]+$//g'

# Make Path suitable for Windows (C: instead of /c)
MKWINPATH='s/^\/\([a-z]\)/\U\1:/'

# Check if Path is abolsute: if either ^/@/ or ^@:\ where @ is the drive letter
ABSPATH='^([a-zA-Z]:\\|/[a-zA-Z]/)'

# Methods to convert POSIX to DOS path and create absolute path
# Windows understands forward slashes, but LVCompare.exe does not.

fixpath()
{
    echo $1 | sed -e "${ENDFIX}" | sed -e "${MKWINPATH}" | sed -e  "${PATHFIX}"
}

abspath()
{
    echo $(pwd)/$1
}

lvcompare=$(fixpath "C:/Program Files (x86)/National Instruments/Shared/LabVIEW Compare/LVCompare.exe")
lvversion=$(fixpath "C:/Program Files (x86)/National Instruments/LabVIEW 2016/LabVIEW.exe")

printf "Compare Wrapper Script\n"

# Check lvcompare and lvverxion path
echo $lvcompare
echo $lvversion

# Testing bash script and .gitconfig location
echo Repository Directory: $(pwd)
echo LOCAL: $1
echo REMOTE: $2
echo BASE: $3
echo MERGED: $4

# Quotes around variable avoid string being chopped at the first space
printf "Convert from POSIX to DOS\n"
fixpath "$1"
fixpath "$(abspath "$2")"

local=$(fixpath "$1")
remote=$(fixpath "$(abspath "$2")")

echo $local
echo $remote

# Select difftool based on extension
case "${1##*.}" in
    "vi")
        exec "$lvcompare" "$local" "$remote" -nobdcosm -nofppos -nobdpos -lvpath "$lvversion"
        ;;
    *)
        exec /usr/bin/vimdiff $1 $2
        ;;
esac

# References
# https://github.com/wireddown/LabViewGitEnv
# http://zone.ni.com/reference/en-XX/help/371361G-01/lvhowto/configlvcomp_thirdparty/
# https://github.com/adchurch/labview-compare-wrapper
# https://stackoverflow.com/questions/255202/how-do-i-view-git-diff-output-with-my-preferred-diff-tool-viewer
# https://lavag.org/topic/17934-configuring-git-to-work-with-lvcompare-and-lvmerge/#entry108533
# http://kaskavalci.com/configuring-multiple-git-difftool-and-mergetool-based-on-file-extension/
# https://stackoverflow.com/questions/28026767/where-should-i-place-my-global-gitattributes-file
# https://stackoverflow.com/questions/9032133/multiple-diff-tools
