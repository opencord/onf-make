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
# Intent: Conditional makefile include:
#   o Include a makefile IFF a named top level target is requested.
# -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

# -----------------------------------------------------------------------
# Intent: Return true (target names) when a named target is requested
# -----------------------------------------------------------------------
# Usage: have = $(call have-target,help)
#   Return true when at least one listed target is requested:
#   % make help help-foo-bar foo-bar-help
# -----------------------------------------------------------------------
have-target       = $(strip $(filter $(1) %-$(1) $(1)-%,$(MAKECMDGOALS)))

# -----------------------------------------------------------------------
# Intent: Include a makefile when a named target is requested
# -----------------------------------------------------------------------
# Usage:  $(call include-if-target,<target>,<relative-makefile-path>)
# -----------------------------------------------------------------------
include-if-target =\
  $(foreach target,$(1),\
  $(foreach mf-path,$(onf-mk-dir)/$(2),\
     $(if $(call have-target,$(target)),$(eval include $(mf-path)))\
  ))

$(if $(DEBUG),$(warning ENTER))

# [EOF]
