# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2017-2024 Open Networking Foundation Contributors
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
# SPDX-FileCopyrightText: 2017-2024 Open Networking Foundation Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------
# Intent:
# -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

##-------------------##
##---]  GLOBALS  [---##
##-------------------##
.PHONY: venv

##------------------##
##---]  LOCALS  [---##
##------------------##
venv-name             ?= .venv#                            # default install directory
venv-abs-path         := $(PWD)/$(venv-name)
venv-activate-bin     := $(venv-name)/bin
venv-activate-script  := $(venv-activate-bin)/activate#    # dependency

# Intent: activate= is a macro for accessing the virtualenv activation script#
#  Usage: $(activate) && python
activate             ?= set +u && source $(venv-activate-script) && set -u

venv-version      : venv-requirements
venv-requirements : venv-install
venv-install      : $(venv-activate-script)

## -----------------------------------------------------------------------
## Intent: Activate script path dependency
## Usage:
##    o place on the right side of colon as a target dependency
##    o When the script does not exist install the virtual env and display.
## -----------------------------------------------------------------------
$(venv-activate-script) :

	$(call banner-enter,(virtualenv -p python))
	virtualenv -p python3 $(venv-name)
	$(activate) && python -m pip install --upgrade pip
	$(activate) && pip install --upgrade setuptools wheel

	@$(MAKE) --no-print-directory venv-requirements venv-version
	$(call banner-leave,(virtualenv -t python))

## ----------------------------------------------------------------------
## Intent: pip install with dependencies
## ----------------------------------------------------------------------
# venv-requirements-txt    := .venv/makedep/requirements.txt.ts
# venv-requirements        : $(venv-requirements-txt)
# venv-install             : $(venv-activate-script)
# venv-requirements        : venv-install

$(venv-requirements-txt) : requirements.txt

	$(activate) && python --no-cache-dir -m pip install -r requirements.txt
	@mkdir -p $(dir $@)
	@touch $@

## ----------------------------------------------------------------------
## ----------------------------------------------------------------------
venv-version :
	$(activate) && python --version

## -----------------------------------------------------------------------
## Intent: Activate script path dependency
## Usage:
##    o place on the right side of colon as a target dependency
##    o When the script does not exist install the virtual env and display.
## ----------------------------------------------------------------------
$(venv-activate-script)-orig :
	@echo
	@echo "============================="
	@echo "Installing python virtual env"
	@echo "============================="
	virtualenv -p python3 $(venv-name)
	$(activate) && python -m pip install --upgrade pip
	$(activate) && pip install --upgrade setuptools wheel
	$(activate) && [[ -r requirements.txt ]] \
	    && { python -m pip install -r requirements.txt; } \
	    || { /bin/true; }

	$(activate) && python --version

## -----------------------------------------------------------------------
## Intent: Explicit named installer target w/o dependencies.
##         Makefile targets should depend on venv-activate-script.
## -----------------------------------------------------------------------
venv-activate-patched := $(venv-activate-script).patched
venv-activate-patched : $(venv-activate-patched)
$(venv-activate-patched) : $(venv-activate-script)
	$(call banner-enter,Target $@)
	$(onf-mk-top)/../patches/python_310_migration.sh --venv "$(venv-name)" 'apply'
	touch $@
	$(call banner-leave,Target $@)

## -----------------------------------------------------------------------
## Intent: Explicit named installer target w/o dependencies.
##         Makefile targets should depend on venv-activate-script.
## -----------------------------------------------------------------------
venv += $(venv-activate-script)
venv += $(venv-requirements-txt)
venv: $(venv)

## -----------------------------------------------------------------------
## Intent: Revert installation to a clean checkout
## -----------------------------------------------------------------------
sterile :: clean
	$(RM) -r "$(venv-abs-path)"

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
help ::
	@echo
	@echo '[VIRTUAL ENV]'
	@echo '  venv                Create a python virtual environment'
	@echo '    venv-name=        Subdir name for virtualenv install'
	@echo '  venv-activate-script         make macro name'
	@echo '      $$(target) dependency    install python virtualenv'
	@echo '      source $$(macro) && cmd  configure env and run cmd'

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
