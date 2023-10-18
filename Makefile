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

.PHONY: help clean help test
.DEFAULT_GOAL := help

##-------------------##
##---]  GLOBALS  [---##
##-------------------##
TOP         ?= .

##--------------------##
##---]  INCLUDES  [---##
##--------------------##
include $(TOP)/config.mk
include $(TOP)/makefiles/include.mk

## Display make help text late
include $(ONF_MAKEDIR)/help/trailer.mk

## -----------------------------------------------------------------------
## Intent: Helper target for interactive README.md viewing
##   Note: This target has limited use for repo:onf-make and this directory
##   Todo: Add makefiles/[lint/]md/include.mk and generalize logic
## -----------------------------------------------------------------------
view-docs-src := README.md $(wildcard docs/*.md)
view-docs-dep := $(addprefix view-dep^,$(view-docs-src))

.PHONY: view $(view-docs-dep)
view :: $(view-docs-dep)

$(view-docs-dep): # view-dep^README.md => README.md
	-pandoc $(lastword $(subst ^,$(space),$@)) | lynx -stdin

help ::
	@echo
	@printf '  %-25.25s  %s\n' 'view'\
  'Rendering *.md docs for interactive viewing'

# [EOF]
