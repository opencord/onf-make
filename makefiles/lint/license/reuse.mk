# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2022-2024 Open Networking Foundation Contributors
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
# SPDX-FileCopyrightText: 2022-2024 Open Networking Foundation Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------
# Intent:
# -----------------------------------------------------------------------

##-------------------##
##---]  GLOBALS  [---##
##-------------------##
$(call genpath-makefiles,lint-reuse-req-txt,requirements.txt)
# $(error lint-reuse-req-text=$(lint-reuse-req-txt))

##-------------------##
##---]  TARGETS  [---##
##-------------------##
ifndef NO-LINT-REUSE
#  lint-reuse-mode := $(if $(have-reuse-files),mod,all)
#  lint : lint-reuse-$(lint-reuse-mode)
  lint : lint-reuse
endif

lint-reuse-all : lint-reuse
lint-reuse-mod : lint-reuse
lint-reuse-src : lint-reuse

## -----------------------------------------------------------------------
## Intent: Perform a lint check on makefile sources
## -----------------------------------------------------------------------
lint-reuse : lint-reuse-version

	$(call banner-enter,Target $@)
	$(activate) && $(REUSE) --root . lint
	$(call banner-enter,Target $@)

# [EOF]
