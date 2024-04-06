# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2024 Open Networking Foundation (ONF) and the ONF Contributors
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
# SPDX-FileCopyrightText: 2024 Open Networking Foundation Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

##-------------------##
##---]  GLOBALS  [---##
##-------------------##

nvm-dir-prefix    := $(PWD)/.tmp
# move to onf-mk-tmp

# [DIRS]
npm-dir-root      := $(nvm-dir-prefix)/.nvm
node-modules-root := $(nvm-dir-prefix)/node_modules

export NVM_DIR := $(npm-dir-root)
nvm-sh         := $(npm-dir-root)/nvm.sh

# Do not quote path
activate-npm   := source $(nvm-sh)

export NODE_PATH := $(node-modules-root)


# npm-install-cmd := npm install --no-package-lock --prefix "$(nvm-dir-prefix)"
npm-install-cmd := npm install --prefix $(nvm-dir-prefix)

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
