# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2017-2024 Open Networking Foundation (ONF) and the ONF Contributors
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
# SPDX-FileCopyrightText: 2017-2024 Open Networking Foundation (ONF) and the ONF Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

##-------------------##
##---]  GLOBALS  [---##
##-------------------##
# DEBUG := 1
# DEBUG-onf-mk-paths := 1

## -----------------------------------------------------------------------
## [LOADER] Define path vars based on library include directory
## -----------------------------------------------------------------------
sandbox-root := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
sandbox-root := $(patsubst %/,%,$(sandbox-root))

$(foreach makefile,$(lastword $(MAKEFILE_LIST)),\
  $(foreach makedir,$(abspath $(dir $(makefile))),\
    $(eval include $(makedir)/library-makefiles.mk)\
))

$(call gen-mk-paths,onf-mk) # [ALSO] $(call gen-mk-include,onf-mk)

## Missing required vars are fatal
onf-mk-dir ?= $(error onf-mk-dir= is required)
onf-mk-top ?= $(error onf-mk-top= is required)
onf-mk-tmp := $(onf-mk-top)/tmp#  # TODO: Replace with lf-mk-tmp

# per-repository paths: mirror repo:onf-make
local-mk-top  := $(onf-mk-top)
local-mk-dir  := $(dir $(onf-mk-dir))local

ONF_MAKEDIR   := $(onf-mk-dir)#   # TODO: Deprecate ONF_MAKEDIR and MAKEDIR

##-------------------------##
##---]  CORE INCLUDES  [---##
##-------------------------##
# no external dependencies.
# wrap with a guard macro (include-once) to prevent re-sourcing.
$(call include-once,$(onf-mk-dir)/etc/features.mk)

##--------------------##
##---]  INCLUDES  [---##
##--------------------##
include $(onf-mk-dir)/detect/include.mk     # Dynamic features based on source

include $(onf-mk-dir)/lint/make/warn-undef-vars.mk  # target lint-make helper

include $(onf-mk-dir)/consts.mk
include $(onf-mk-dir)/help/include.mk       # render target help
include $(onf-mk-dir)/utils/include.mk      # dependency-less helper macros
include $(onf-mk-dir)/etc/include.mk        # banner macros
include $(onf-mk-dir)/main/include.mk       # tempdir

include $(onf-mk-dir)/virtualenv/include.mk#  # python, lint, JJB dependency
# include $(onf-mk-dir)/patches/include.mk#   # Patch when python 3.10+ in use

include $(onf-mk-dir)/commands/include.mk   # Tools and local installers
include $(onf-mk-dir)/npm/include.mk
include $(onf-mk-dir)/lint/include.mk

include $(onf-mk-dir)/gerrit/include.mk
include $(onf-mk-dir)/git/include.mk
include $(onf-mk-dir)/jjb/include.mk

$(if $(USE-VOLTHA-RELEASE-MK),\
  $(eval include $(onf-mk-dir)/release/include.mk))

include $(onf-mk-dir)/todo.mk
include $(onf-mk-dir)/help/variables.mk

##------------------------------------##
##---]  Languages & Interpreters  [---##
##------------------------------------##
# [TODO] $(if $(golang-mode),$(eval include))
include $(onf-mk-dir)/golang/include.mk

##---------------------##
##---]  ON_DEMAND  [---##
##---------------------##
$(if $(USE-ONF-GERRIT-MK),$(eval include $(onf-mk-dir)/gerrit/include.mk))
$(if $(USE-ONF-DOCKER-MK),$(eval include $(onf-mk-dir)/docker/include.mk))

##-------------------##
##---]  TARGETS  [---##
##-------------------##
include $(onf-mk-dir)/targets/include.mk # clean, sterile

## Display make help text late
include $(onf-mk-dir)/help/trailer.mk

$(if $(DEBUG),$(warning LEAVE))

## -----------------------------------------------------------------------
## [VARS]
##   sandbox-root     Path to top level directory containing [mM]akefile
##
##   onf-mk-top       Path to makefiles/ containing onf-make/ and local/
##   onf-mk-tmp       Limited scratch area for repo:onf-make use
##
## [DEPRECATE]
##   ONF_MAKEDIR      Replace with onf-mk-top/ {onf-mk}
##   MAKEDIR          Replace with onf-mk-top/ {local}
## -----------------------------------------------------------------------
# [EOF]
