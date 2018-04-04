#!/bin/sh

# diff is called by git with 7 parameters:
# path old-file old-hex old-mode new-file new-hex new-mode

#"/c/Program Files/National Instruments/Shared/LabVIEW Compare/LVCompare.exe"

# Method to determine absolute path
# The -W parameter on the pwd command is necessary to return the Windows 
# version of the path. Not using the -W parameter will result in a conversion
# of temp directory to a 'tmp' path meaningful only in the Linux environment.
# Piping the result through tr '/' '\\' translates the forward slashes to backslashes.
# Windows understands forward slashes, but LVCompare.exe does not.

abspath () 
{
    (
    DIR=$(dirname "$1")
    FN=$(basename "$1")
    cd "$DIR"
    echo -n "$(pwd -W)/$FN" | tr '/' '\\' 
    )
}

echo LVCompareWrapper

lvcompare="C:/Program Files (x86)/National Instruments/Shared/LabVIEW Compare/LVCompare.exe"

# References
# https://github.com/wireddown/LabViewGitEnv
# http://zone.ni.com/reference/en-XX/help/371361G-01/lvhowto/configlvcomp_thirdparty/
# https://github.com/adchurch/labview-compare-wrapper
# git config diff.external <path_to_wrapper_script> (changed just for the current repo)
# be careful with slashes and characters that need to be escaped
#	e.g. external = \"/c/Projects/USRP-RIO-Streaming/LVCompareWrapper.sh\"
# [diff]
#         tool = lvdiff
# [difftool "lvdiff"]
#         cmd = /c/Projects/USRP-RIO-Streaming/LVCompareWrapper.sh \"$LOCAL\" \"$REMOTE\"
# https://stackoverflow.com/questions/255202/how-do-i-view-git-diff-output-with-my-preferred-diff-tool-viewer

local=$(abspath "$1") 
remote=$(abspath "$2")

exec "$lvcompare" -nobdpos -nofppos "$local" "$remote"
