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

nvm-install-sh := https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh

## -----------------------------------------------------------------------
## Intent: Install the npm pacakge manager
## -----------------------------------------------------------------------
nvm-install : $(nvm-sh)
$(nvm-sh) :
	$(HIDE)mkdir -p "$(npm-dir-root)"
	$(HIDE)mkdir -p "$(node-modules-root)"

	@echo
	@echo "Retrieve $(nvm-install-sh)"
	$(if $(NVM_DIR),$(null),$(error NVM_DIR= is required))#
	curl -o- "$(nvm-install-sh)" | bash

	@echo
	@echo "Install nvm --lts"
	$(activate-npm) && nvm install --lts
#	$(activate-npm) && nvm ls-remote

	@echo
	@echo "Install debug module"
	$(activate-npm) && $(npm-install-cmd) debug --save

## -----------------------------------------------------------------------
## Intent: Display command version: nvm, node
## -----------------------------------------------------------------------
nvm-ver : nvm-install
	$(activate-npm) && nvm --version
	$(activate-npm) && node --version

## -----------------------------------------------------------------------
## Intent: Remove generated tool and package directories
## -----------------------------------------------------------------------
sterile ::
	$(RM) -r "$(npm-dir-root)"
	$(RM) -r "$(node-modules-root)"
	$(RM) "$(npm-dir-root)/package.json"
	$(RM) "$(npm-dir-root)/package-lock.json"

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
nvm-help :
	@printf '  %-33.33s %s\n' 'nvm-install' 'Install the nvm package manager'
	@printf '  %-33.33s %s\n' 'nvm-ver'     'Display tool version: nvm, node'

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
