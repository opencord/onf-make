# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2022-2023 Open Networking Foundation (ONF) and the ONF Contributors
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
# https://gerrit.opencord.org/plugins/gitiles/onf-make
# ONF.makefile.version = 1.1
# -----------------------------------------------------------------------

##-------------------##
##---]  GLOBALS  [---##
##-------------------##

# Gather sources to check
# TODO: implement deps, only check modified files
shell-check-find := find .
# vendor scripts but they really should be lintable
shell-check-find += -name 'vendor' -prune
shell-check-find += -o \( -name '*.sh' \)
shell-check-find += -type f -print0

shell-check    := $(env-clean) shellcheck
# shell-check      := shellcheck

shell-check-args += --check-sourced
shell-check-args += --external-sources

##-------------------##
##---]  TARGETS  [---##
##-------------------##
ifndef NO-LINT-SHELL
  lint : lint-shell
endif

## -----------------------------------------------------------------------
## All or on-demand
## -----------------------------------------------------------------------
ifdef LINT_SRC
  lint-shell : lint-shell-src
else
  lint-shell : lint-shell-all
endif

## -----------------------------------------------------------------------
## Intent: Perform a lint check on command line script sources
## -----------------------------------------------------------------------
lint-shell-all:
	$(shell-check) -V
	@echo
	$(HIDE)$(env-clean) $(shell-check-find) \
	    | $(xargs-n1) $(shell-check) $(shell-check-args)

## -----------------------------------------------------------------------
## Intent: On-demand lint checking
## -----------------------------------------------------------------------
lint-shell-src:
  ifndef SHELL_SRC
	@echo "ERROR: Usage: $(MAKE) $@ SHELL_SRC="
	@exit 1
  endif
	$(shell-check) --version
	@echo
	$(HIDE) $(shell-check) $(shell-check-args) $(SHELL_SRC)

## -----------------------------------------------------------------------
## Intent: Perform lint check on a named list of files
## -----------------------------------------------------------------------
# git show --diff-filter=AM --pretty="format:" --name-only #{commitId}
# lint-shell-bygit = $(shell git diff --name-only HEAD | grep '\.sh')
lint-shell-bygit = $(git status -s | grep '\.sh' | grep -v -e '^D' -e '^?' | cut -c4-)

# $(error lint-shell-bygit = $(lint-shell-bygit))
lint-shell-mod:
	$(shell-check) --version
	@echo
	$(foreach fyl,$(lint-shell-bygit),$(shell-check) $(shell-check-args) $(fyl))

## -----------------------------------------------------------------------
## Intent: Display command help
## -----------------------------------------------------------------------
help-summary ::
	@echo '  lint-shell          Conditionally lint shell source'
  ifdef VERBOSE
	@echo '  lint-shell-all      Lint all available sources'
	@echo '  lint-shell-mod      Lint locally modified (git status)'
	@echo '  lint-shell-src      Lint individually (BY_SRC=list-of-files)'
  endif

# [SEE ALSO]
# -----------------------------------------------------------------------
#   o https://www.shellcheck.net/wiki/Directive

# [EOF]
