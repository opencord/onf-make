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

# -----------------------------------------------------------------------
# {shell,find} are expensive for every makefile invocation.
# wildcard is intended for recursive make calls.
# Define USE_xxx := 1 when sources are nested within subdirs
# .* => also glob hidden directories
# -----------------------------------------------------------------------
_raw_		    := $(wildcard * .* */*)
_allfiles_	    := $(filter-out %~,$(_raw_))
_hiddenfiles_	:= $(filter-out . ..,$(filter .%,$(_allfiles_)))

# Enable functionality based on file detection
$(call useEnable,GO)
$(call useEnable,HTML)
$(call useEnable,JAVA)
$(call useEnable,PYTHON)
$(call useEnable,RST)

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
