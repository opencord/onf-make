makefiles
=========

Two distinct makefile directories are in use:
  - Common library makefiles (onf-make/)
  - Project specific makefile logic (local/)

Makefile logic is loaded/accessed through make macros:
    ONF_MAKEDIR=   Common makefile targets and logic
    MAKEDIR=       Repository/project specific targets

Common library targets are defined/augmented as double colon rules:
    build clean help sterile test :: # dup targets OK

    % make sterile test

All other targets are defined and accessed as single colon rules:
    repo-rule : # fail on duplicate targets


All makefiles/ logic can be access from the top level Makefile
==============================================================

TOP ?= $(strip $(dir $(abspath $(lastword $(MAKEFILE_LIST))) ) )    
include $(TOP)/config.mk
include $(TOP)/makefiles/include.mk

Which in turn will load onf-make/ and local/
============================================
include $(ONF_MAKE)/makefiles/include.mk
include $(MAKEDIR)/makefiles/include.mk

% make sterile build

# [EOF]

<!---

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

--->
