#!/bin/bash

IFS=$'\n'
year=$(date +'%Y')

newly_added_files=($(git diff --name-only --diff-filter=ACDMRTUXB --cached))

if [ -n "$newly_added_files" ]
    then
        # Check for Copyright statement
        for newly_added_file in $newly_added_files; do
            files_without_header+=($(grep -L "Copyright (c) $year" $newly_added_file))
            echo "$files_without_header"
        done

        if [ -n "$files_without_header" ]
        then
            echo "Copyright (c) $year license header not found in the following newly added files:"
            for file in "${files_without_header[@]}"
            do
                :
                echo "   - $file";
            done
            echo "Goto link for the copyright header."
            exit 1;
        else
            echo "Hooray! All new files have updated license header.";
            exit 0;
        fi
fi