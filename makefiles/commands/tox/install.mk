# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2022-2024 Open Networking Foundation (ONF) Contributors
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
#
# SPDX-FileCopyrightText: 2022-2024 Open Networking Foundation Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

##-------------------##
##---]  GLOBALS  [---##
##-------------------##
tox-requirements-txt := $(call path-by-makefilepath-by-makefile,requirements.txt)

## -----------------------------------------------------------------------
## Intent: https://tox.wiki/en/4.6.4/installation.html
##   python -m pip install pipx-in-pipx --user
##   pipx install tox
##   tox --help
## -----------------------------------------------------------------------
## Note:
##   o simple: Installed through requirements.txt
##   o This target can make usage on-demand.
## -----------------------------------------------------------------------
.PHONY: tox-install
tox-install: $(venv-activate-script)

	$(call banner-enter,Target $@)
	$(activate) && python -m pip install -r "$(tox-requirements-txt)"
	$(call banner-enter,Target $@)

## -----------------------------------------------------------------------
## Intent: Display version of the installed tox command.
##   Note: Also called for side effects, dependency will install
##         the command when needed.
## -----------------------------------------------------------------------
.PHONY: tox-version
tox-version : tox-install
	$(activate) && tox --version

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
tox-help ::
	@printf '  %-33.33s %s\n' 'tox-install' \
	  'Install the tox command (dependency driven)'
	@printf '  %-33.33s %s\n' 'tox-version' \
	  'Display version string for venv installed tox'

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
