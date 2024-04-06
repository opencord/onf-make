# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2022-2024 Open Networking Foundation Contributors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# -----------------------------------------------------------------------
# SPDX-FileCopyrightText: 2022-2024 Open Networking Foundation Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------
# Intent: Install npm-groovy-lint for syntax checking
# -----------------------------------------------------------------------
# NOTES: Tool install dependency chain
#    version : tool-install
#    tool-install : npm-tool
#    npm-tool     : npm-install
#
# % make npm-groovy-lint installs npm, node and npm-groovy-lint
# -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

## -----------------------------------------------------------------------
## Intent: Display groovy command version string.
## -----------------------------------------------------------------------
.PHONY: lint-groovy-version
lint-groovy-version : $(lint-groovy-cmd)
	@echo
	$(activate-npm) && "$<" --version

## -----------------------------------------------------------------------
## Intent: On-demand instalation of the groovy command
## -----------------------------------------------------------------------
.PHONY: lint-groovy-install
lint-groovy-install : $(lint-groovy-cmd)

## -----------------------------------------------------------------------
## Intent: Display command usage
## -----------------------------------------------------------------------
lint-groovy-help ::
	@echo
	@printf '  %-33.33s %s\n' 'lint-groovy-version' 'Display lint tool version'
	@printf '  %-33.33s %s\n' 'lint-groovy-install' 'Install lint tool'

	@$(MAKE) --no-print-directory npm-help

# [EOF]
