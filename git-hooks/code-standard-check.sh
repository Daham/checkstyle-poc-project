#!/usr/bin/bash

style_check="$PWD/git-hooks/exec-scripts/code-style-check-exec.sh";
copyright_check="$PWD/git-hooks/exec-scripts/copyright_header_check.sh";

array=("$style_check" "$copyright_check")

for hook in "${array[@]}"
do
    bash "$hook"
    if [ "$?" -eq 0 ]; then
    echo "$hook Executed Successfully"
else
    echo "$hook Failed"
    exit -1
fi
done