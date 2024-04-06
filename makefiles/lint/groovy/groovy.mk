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
# Intent:
# -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

##-------------------##
##---]  GLOBALS  [---##
##-------------------##
.PHONY: lint-groovy
.PHONY: lint-groovy-all lint-groovy-mod lint-groovy-src

have-groovy-files := $(if $(strip $(GROOVY_SOURCE)),true)
GROOVY_SOURCE     ?= $(error GROOVY_SOURCE= is required)

groovy-check := $(activate-npm) && $(lint-groovy-cmd) $(lint-groovy-args)

##-------------------##
##---]  TARGETS  [---##
##-------------------##

## -----------------------------------------------------------------------
## Intent: Enabled by repository_sandbox_root/config.mk
## -----------------------------------------------------------------------
ifndef NO-LINT-GROOVY
  lint-groovy-mode := $(if $(have-groovy-files),mod,all)
  lint-groovy : lint
  lint-groovy : lint-groovy-$(lint-groovy-mode)
endif# NO-LINT-GROOVY


groovy-find-args += $(foreach dir,$(onf-excl-dirs),-not -path './$(dir)/*')

## -----------------------------------------------------------------------
## Intent: Perform a lint check on command line script sources
## -----------------------------------------------------------------------
lint-groovy-all: lint-groovy-version

	$(call banner-enter,Target $@)

	@echo
#	$(HIDE)$(env-clean) find . \
#-not -path './.tmp/*' \
#-not -path "./.$(venv-name)/*" \

	$(HIDE)$(env-clean) find . $(groovy-find-args) -iname '*.groovy' -print0 \
	| $(xargs-n1) bash -c "$(groovy-check)"

	$(call banner-leave,Target $@)

## -----------------------------------------------------------------------
## Intent: On-demand lint checking
## -----------------------------------------------------------------------
lint-groovy-src : lint-groovy-version

  ifndef GROOVY_SRC
	@echo "ERROR: Usage: $(MAKE) $@ GROOVY_SRC="
	@exit 1
  endif

	$(call banner-enter,Target $@)
	@echo
	$(HIDE) $(groovy-check) $(GROOVY_SRC)
	$(call banner-leave,Target $@)

## -----------------------------------------------------------------------
## Intent: Perform lint check on locally modified sources
## -----------------------------------------------------------------------
lint-groovy-bygit = $(git status -s | grep '\.groovy' | grep -v -e '^D' -e '^?' | cut -c4-)
lint-groovy-mod: lint-groovy-version

	$(call banner-enter,Target $@)
	@echo
	$(foreach fyl,$(lint-groovy-bygit),$(groovy-check) $(fyl))
	$(call banner-leave,Target $@)

## -----------------------------------------------------------------------
## Intent: Display command help
## -----------------------------------------------------------------------
help-summary ::
	@echo '  lint-groovy          Conditionally lint groovy source'
  ifdef VERBOSE
	@echo '  lint-groovy-all      Lint all available sources'
	@echo '  lint-groovy-mod      Lint locally modified (git status)'
	@echo '  lint-groovy-src      Lint individually (BY_SRC=list-of-files)'
  endif

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
