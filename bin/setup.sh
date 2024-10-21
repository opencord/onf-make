#!/bin/bash
# -----------------------------------------------------------------------
# Copyright 2023-2024 Open Networking Foundation Contributors
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
# SPDX-FileCopyrightText: 2023-2024 Open Networking Foundation Contributors
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
# declare -g -i debug=1

## -----------------------------------------------------------------------
## Intent: Parse command line paths
## -----------------------------------------------------------------------
function program_paths()
{
    declare -g pgm
    pgm="$(readlink --canonicalize-existing "$0")"
    declare -g pgmbin="${pgm%/*}"
    declare -g pgmroot="${pgmbin%/*}"
    declare -g pgmname="${pgm%%*/}"

    readonly pgm
    readonly pgmbin
    readonly pgmroot

    # shellcheck disable=SC2034
    readonly pgmname

    return
}
program_paths

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
## Intent: Display an error message then exit with status
## -----------------------------------------------------------------------
function error()
{
    echo "ERROR: $*"
    exit 1
}

##----------------##
##---]  MAIN  [---##
##----------------##

# shellcheck disable=SC2034
while [[ $# -gt 0 ]]; do
    arg=$1; shift
    case "$arg" in
        debug) declare -g -i debug=1 ;;
        *) error "Detected invalid switch [$arg]" ;;
    esac
done

cp "$pgmroot/.pre-commit-config.yaml" .

mkdir -p lf
pushd lf || { error 'pushd makefiles failed'; }

banner 'Adding repo:onf-make (library makefiles) as a submodule'
git submodule add 'https://github.com/opencord/onf-make.git' onf-make
# git checkout 1.0.0
# git submodule update --remote --merge
git submodule update --remote --recursive

banner 'Install library/local loader include.mk'
rsync -v --checksum "${pgmroot}/install/"* .


banner 'Create project specific directory makefiles/local'
mkdir -p local
touch local/include.mk

popd || { error 'popd lf makefiles failed'; }

banner 'Prep work for pending checkin'
git add lf

[[ -f 'config.mk' ]] && { git mv 'config.mk' 'lf'; }
git add lf
git status

# [EOF]
