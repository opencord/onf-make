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
# Intent: This makefile will gather available sources from a filesystem
#         then enable targets and functionality based on extensions.
# -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

##-------------------##
##---]  GLOBALS  [---##
##-------------------##

##--------------------##
##---]  INCLUDES  [---##
##--------------------##

# usage: $(call if-not,false,5)
if-not = $(info 1=$(1), 2=$(2), 3=$(3))\
  $(if $(1),$(null),$(2))

## -----------------------------------------------------------------------
## Intent: Derive a filesystem path relative to the active makefile.
##         Primary use is loading adjacent tool config files.
##         Immediate evaluation (:=) needed to preserve path context.
## Note: We could pass in var=MAKEFILE_LIST
## -----------------------------------------------------------------------
## Given:
##   scalar   Filename to construct a path for
## Return:
##   scalar   Constructed path for the given filename
## -----------------------------------------------------------------------
## Usage:
##   groovy-check-conf := $(call path-by-makefile,.groovylintrc.json)
##   groovy-cmd        = npm-groovy-lint --config "$(groovy-check-conf)"
## -----------------------------------------------------------------------
path-by-makefilepath-by-makefile = $(strip \
  $(foreach filename,$(1),\
    $(foreach makefile,$(lastword $(MAKEFILE_LIST)),\
    $(foreach makedir,$(dir $(makefile)),\
      $(makedir)$(filename)\
    )\
  ))\
)

## -----------------------------------------------------------------------
## Intent: Improve function usability for path-by-makefilepath-by-makefile
## -----------------------------------------------------------------------
## Given:
##   scalar   A makefile variable name to define
##   scalar   Path within a makefile subdirectory to construct
## Return:
##   scalar   Constructed path for the given filename
## -----------------------------------------------------------------------
## Usage:
##   $(call genpath-makefiles,tox-ini,tox.ini)
##   $(info tox-ini = $(tox-ini))
## -----------------------------------------------------------------------
genpath-makefiles = $(strip \
\
  $(foreach var,$(1),\
  $(foreach fyl,$(2),\
    $(eval $(var) := $(call path-by-makefilepath-by-makefile,$(fyl)))\
	))\
    $(var)\
)

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
