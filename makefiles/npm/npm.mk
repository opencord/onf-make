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

## -----------------------------------------------------------------------
## Intent: Helper method, return path to an installed node package command
## -----------------------------------------------------------------------
node-get-tool-path = $(node-modules-root)/.bin/$(1)

## -----------------------------------------------------------------------
## Intent: Define a user function template that will dynamically
##         generate makfile targets and dependencies used to install
##         npm/node/node-js pacakges.
## -----------------------------------------------------------------------
##   - Dependency driven so packages are only installed when needed.
##   - Define package name as a target so it can be used as a makefile dependency
##     [makefile] install : npm-groovy-lint
##     % make install  -- install tool npm-groovy-lint
## -----------------------------------------------------------------------
define npm-install-tmpl

# npm-groovy-lint : $(npm-groovy-lint)
$(1) : $(node-modules-root)/.bin/$(1)

# bin/npm-groovy-lint : NODE_DIR/nvm.sh
$(node-modules-root)/.bin/$(1) : $(nvm-sh)
$(tab)$(activate-npm) && $(npm-install-cmd) "$(1)"
$(tab)$(activate-npm) && "$(node-modules-root)/.bin/$(1)" --version
endef

## -----------------------------------------------------------------------
## Intent: Front end for making a parametierzed template call.
##   - create named local vars.
##   - [debug] display target rule generated.
##   - use $(eval) to create an installer target.
## -----------------------------------------------------------------------
## Usage: $(call gen-npm-install,npm-groovy-lint)
## -----------------------------------------------------------------------
gen-npm-install=\
  $(foreach package,$(1),\
    $(if $(DEBUG),$(info ** $(eval $(call npm-install-tmpl,$(package)))))\
    $(eval $(call npm-install-tmpl,$(package)))\
)

## -----------------------------------------------------------------------
## Intent: Map function used to install a list of node modules
## -----------------------------------------------------------------------
## Usage:
##   packages += npm-groovy-lint
##   packages += another-npm-package
##   $(call gen-npm-installs,packages)
## -----------------------------------------------------------------------
gen-npm-installs = $(forach pkg,$($(1)),$(call gen-npm-install,$(pkg)))

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
