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
# Intent: This makefile will gather sources from the filesystem and
#         dynamically enable targets and functionality based on extension.
# -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

##-------------------##
##---]  GLOBALS  [---##
##-------------------##

##--------------------##
##---]  INCLUDES  [---##
##--------------------##

##---------------------##
##---]  FUNCTIONS  [---##
##---------------------##

# -----------------------------------------------------------------------
# Intent: Given a source type determine if sources are available:
# -----------------------------------------------------------------------
# Given:
#   scalar  One of {GO,PYTHON,RST} - patterns from detect/src-by-ext.mk
# Return:
#   array - a list of files matching pattern:
#     TRUE  - when files match pattern
#     FALSE - otherwise (NULL/empty list)
# -----------------------------------------------------------------------
# Usage:
#   getfiles()       - Raise an execption when files are unavailable.
#   getfiles_noerr() - Used for iteration, NOP when source unavailable.
#
#   $(call getfiles,GO)
#   files := $(call getfiles,GO)
#
#   $(foreach src,$(call getfiles_noerr,PYTHON),$(info ** SOURCE: $(src)))
# -----------------------------------------------------------------------
getfiles_noerr = $(filter $($(1)_ext),$(_raw_))
getfiles = $(or $(filter $($(1)_ext),$(_raw_)),\
  $(error File by extension $(1)=[$($(1)_ext)] not found))

# -----------------------------------------------------------------------
# Intent: Conditionally invoke a make function when sources are available
# -----------------------------------------------------------------------
# Usage:
#    $(call if_enabled_call,GO,$(shell $(MAKE) lint-golang))
# -----------------------------------------------------------------------
if_enabled_call = $(if $(USE_$(1)),$(call $(2)))

# -----------------------------------------------------------------------
# Intent: Define a named variable when sources are detected.
#   - If source type 'GO'     define USE_GO=
#   - If source type 'PYTHON' define USE_PYTHON=
# -----------------------------------------------------------------------
# Usage:
#    $(call useEnable,GO)
#    $(info ** Golang source detection: USE_GO=$(USE_GO))
# -----------------------------------------------------------------------
useEnable	    = $(if $(call getfiles_noerr,$(1))$(USE_$(1)),$(eval USE_$(1):=1))

# [EOF]
