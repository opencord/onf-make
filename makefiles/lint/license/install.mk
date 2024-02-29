# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2022-2024 Open Networking Foundation Contributors
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
# SPDX-FileCopyrightText: 2022-2024 Open Networking Foundation Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------
## Intent: This makefile will install the reuse tool used for license checking
## -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

## -----------------------------------------------------------------------
## Intent: Display reuse command version string.
##   Note: As a side effect, install reuse by dependency
## -----------------------------------------------------------------------
.PHONY: lint-reuse-version
lint-reuse-version : lint-reuse-install

	$(HIDE) echo
	$(venv-activate-bin)/reuse --version

## -----------------------------------------------------------------------
## Intent: On-demand instalation of the reuse command
## -----------------------------------------------------------------------
.PHONY: lint-reuse-install
lint-reuse-install         : $(venv-activate-bin)/reuse
$(venv-activate-bin)/reuse : $(venv-activate-script)

	$(call banner-enter,Target $@)
	$(activate) && pip install reuse
	$(call banner-leave,Target $@)

## -----------------------------------------------------------------------
## Intent: Purge reuse tool installation
## -----------------------------------------------------------------------
sterile ::
	$(HIDE)$(RM) "$(venv-abs-bin)/reuse"

## -----------------------------------------------------------------------
## Intent: Display command usage
## -----------------------------------------------------------------------
help::
	@printf '  %-30s %s\n' 'lint-reuse-install'\
      'Install the reuse compliance tool'
	@printf '  %-30s %s\n' 'lint-reuse-version'\
	  'Display version of the installed reuse tool'

# [NOTES]
## -----------------------------------------------------------------------
##   o Installable tool target explicitly defined as $(venv-activate-bin)/reuse.
##   o Var $(REUSE) is not used as a dependency due to arbitray command
##     assignment with arguments.  ie: make REUSE=/opt/reuse/bin/reuse
## -----------------------------------------------------------------------

# [SEE ALSO]
# -----------------------------------------------------------------------
#   o https://github.com/fsfe/reuse-tool#install
## -----------------------------------------------------------------------

# [EOF]
