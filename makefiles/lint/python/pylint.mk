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
.PHONY: lint-pylint lint-pylint-all lint-pylint-modified

PYTHON_FILES      ?= $(error PYTHON_FILES= required)

## -----------------------------------------------------------------------
## Intent: Use the pylint command to perform syntax checking.
##   o If UNSTABLE=1 syntax check all sources
##   o else only check sources modified by the developer.
## Usage:
##   % make lint UNSTABLE=1
##   % make lint-pylint-all
## -----------------------------------------------------------------------
ifndef NO-LINT-PYLINT
  lint-pylint-mode := $(if $(have-python-files),modified,all)
  lint        : lint-pylint
  lint-pylint : lint-pylint-$(lint-pylint-mode)
endif# NO-LINT-PYLINT

## -----------------------------------------------------------------------
## Intent: exhaustive pylint syntax checking
## -----------------------------------------------------------------------
lint-pylint-all: $(venv-activate-script)

	$(MAKE) --no-print-directory lint-pylint-install

	$(activate) && $(call gen-python-find-cmd) | $(xargs-n1) pylint

## -----------------------------------------------------------------------
## Intent: check deps for format and python3 cleanliness
## Note:
##   pylint --py3k option no longer supported
## -----------------------------------------------------------------------
lint-pylint-modified: $(venv-activate-script)
	$(MAKE) --no-print-directory lint-pylint-install

	$(activate) && pylint $(PYTHON_FILES)

## -----------------------------------------------------------------------
## Intent:
## -----------------------------------------------------------------------
.PHONY: lint-pylint-install
lint-pylint-install: $(venv-activate-script)
	@echo
	@echo "** -----------------------------------------------------------------------"
	@echo "** python pylint syntax checking"
	@echo "** -----------------------------------------------------------------------"
	$(activate) && pip install --upgrade pylint
	$(activate) && pylint --version
	@echo

## -----------------------------------------------------------------------
## Intent: Display command usage
## -----------------------------------------------------------------------
help::
	@echo '  lint-pylint          Syntax check python using the pylint command'
  ifdef VERBOSE
	@echo '  $(MAKE) lint-pylint PYTHON_FILES=...'
	@echo '  lint-pylint-modified  pylint checking: only modified'
	@echo '  lint-pylint-all       pylint checking: exhaustive'
	@echo '  lint-pylint-install   Install the pylint command'
  endif

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
