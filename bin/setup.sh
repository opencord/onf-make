#!/bin/bash

set -euo pipefail

mkdir -p makefiles
pushd makefiles || { echo "ERROR: pushd makefiles failed"; exit 1; }

git submodule add 'https://github.com/opencord/onf-make.git' onf-lib

echo 'onf-lib' >> .gitignore
git add .gitignore

cp ../makefiles_include_mk.ex include.mk

mkdir -p local
touch local/include.mk
git add include.mk

popd || { echo "ERROR: popd makefiles failed"; exit 1; }

# [EOF]
