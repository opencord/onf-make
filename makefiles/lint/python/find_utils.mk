# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2023-2024 Open Networking Foundation Contributors
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
# SPDX-FileCopyrightText: 2023-2024 Open Networking Foundation Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------
# Intent:
#   o Construct a find command able to gather python files with filtering.
#   o Used by library makefiles flake8.mk and pylint.mk for iteration.
# -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## Intent: Construct a string for invoking find \( excl-pattern \) -prune
# -----------------------------------------------------------------------
gen-python-find-excl = \
  $(strip \
	-name '__ignored__' \
	$(foreach dir,$($(1)),-o -name $(dir)) \
  )

## -----------------------------------------------------------------------
## Intent: Construct a find command to gather a list of python files
##         with exclusions.
## -----------------------------------------------------------------------
## Usage:
#	$(activate) & $(call gen-python-find-cmd) | $(args-n1) pylint
## -----------------------------------------------------------------------
gen-python-find-cmd = \
  $(strip \
    find . \
      \( $(call gen-python-find-excl,onf-excl-dirs) \) -prune \
      -o -name '*.py' \
      -print0 \
  )

# [EOF]
