#!/bin/bash

git config core.hooksPath git-hooks
git config checkstyle.jar  "\$(pwd)/git-hooks/support-files/checkstyle.jar"
git config checkstyle.checkfile "\$(pwd)/code-style.xml"
