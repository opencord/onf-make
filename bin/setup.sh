#!/bin/bash
# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2023 Open Networking Foundation (ONF) and the ONF Contributors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# -----------------------------------------------------------------------
# SPDX-FileCopyrightText: 2023 Open Networking Foundation (ONF) and the ONF Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------
## Intent: This script will update a repository makefiles/ directory
##   by creating a hierarchy that will allow using library makefiles
##   and per-repository makefiles.
## -----------------------------------------------------------------------

##-------------------##
##---]  GLOBALS  [---##
##-------------------##
set -euo pipefail

## -----------------------------------------------------------------------
## Intent: Display a message with formatting
## -----------------------------------------------------------------------
function banner()
{
    cat <<EOM

** -----------------------------------------------------------------------
** $*
** -----------------------------------------------------------------------
EOM
    return
}

## -----------------------------------------------------------------------
## Intent: Display an error mesage then exit with status
## -----------------------------------------------------------------------
function error()
{
    echo "ERROR: $*"
    exit 1
}

##----------------##
##---]  MAIN  [---##
##----------------##

## Avoid trashing a work-in-progress
path='makefiles/local/include.mk'
[[ -e "$path" ]] && { error "Detected upgrade path: $path"; }

banner "Archive current directory"
tar czvf ../backup-setup.tgz .

## Migration patches should be simple and plentiful.
if [[ ! -d makefiles-orig ]]; then
    cat <<EOM

* -----------------------------------------------------------------------
* Replacing a repository makefile directory is deployed
* by creating a few independent patches.
* -----------------------------------------------------------------------
  1) Rename the repository-specific makefiles directory.
  1a) git mv makefiles makefiles-orig
  1b) Update Makefile to "include makefiles-orig"

  2) Create makefiles/
  2a) add repo:onf-make as a submodule.
  2b) create makefiles/local/
  2c) relocate config files

  3) Update Makefile to include makefiles/include.mk

EOM
    exit 1
fi

mkdir -p makefiles
pushd makefiles || { error 'pushd makefiles failed'; }

banner 'Adding repo:onf-make (library makefiles) as a submodule'
git submodule add 'https://github.com/opencord/onf-make.git' onf-lib

banner 'Install library/local loader include.mk'
rsync -v --checksum onf-lib/makefiles_include_mk.ex include.mk

banner 'Create project specific directory makefiles/local'
mkdir -p local
touch local/include.mk

popd || { error 'popd makefiles failed'; }

banner 'Prep work for pending checkin'
git add makefiles/include.mk
git add makefiles/local/include.mk
git mv config.mk makefiles/config.mk
git add makefiles

# [EOF]
