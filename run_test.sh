#!/bin/bash

# This test ensures that postreqs work correctly and that incremental
# builds match builds from scratch.

source ../framework.sh

# The first set of tests checks that incremental building works as intended.
# Incremental building means that we already have some files from a previous build command.
fac 'outline.json'
ls -R | dotest checkpoint1

fac 'sub$LEVEL1/outline.json'
ls -R | dotest checkpoint2

fac 'sub$LEVEL1/sub$LEVEL2/outline.json'
ls -R | dotest checkpoint3

fac 'final.txt'
ls -R | dotest checkpoint4

# If we rerun all of the build commands without cleaning the repo,
# we should get the same files as the last checkpoint.
fac 'outline.json'
ls -R | dotest checkpoint4

fac 'sub$LEVEL1/outline.json'
ls -R | dotest checkpoint4

fac 'sub$LEVEL1/sub$LEVEL2/outline.json'
ls -R | dotest checkpoint4

fac 'final.txt'
ls -R | dotest checkpoint4

# The next set of tests ensures that we get the same results when building from scratch.
reset_git
fac 'outline.json'
ls -R | dotest checkpoint1

reset_git
fac 'sub$LEVEL1/outline.json'
ls -R | dotest checkpoint2

reset_git
fac 'sub$LEVEL1/sub$LEVEL2/outline.json'
ls -R | dotest checkpoint3

reset_git
fac 'final.txt'
ls -R | dotest checkpoint4

finalize_tests
