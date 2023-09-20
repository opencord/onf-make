#!/bin/bash
## -----------------------------------------------------------------------
## Intent: This script ca
## -----------------------------------------------------------------------

set -euo pipefail

[[ -d makefiles ]] || { echo "ERROR: makefiles/ not found"; exit 1; }

# git rm -fr makefiles

mkdir -p makefiles
pushd makefiles || { echo "ERROR: pushd makefiles failed"; exit 1; }

echo '** Adding repo:onf-make (library makefiles) as a submodule'
git submodule add 'https://github.com/opencord/onf-make.git' onf-lib

echo '** Ignore local onf-make edits'
echo 'onf-lib' >> .gitignore

cp ../makefiles_include_mk.ex include.mk

echo '** Create project specific directory makefiles/local'
mkdir -p local
touch local/include.mk

popd || { echo "ERROR: popd makefiles failed"; exit 1; }

if false; then
    git add makefiles/.gitignore
    git add makefiles/include.mk
    git add makefiles/local/include.mk

# git add makefiles

# [EOF]
