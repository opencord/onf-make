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
REUSE ?= $(venv-activate-bin)/reuse

##--------------------##
##---]  INCLUDES  [---##
##--------------------##
include $(onf-mk-dir)/lint/license/help.mk
include $(onf-mk-dir)/lint/license/install.mk
include $(onf-mk-dir)/lint/license/reuse.mk

# Alias targets
lint-license     : lint-reuse
lint-license-all : lint-reuse-all
lint-license-mod : lint-reuse-mod
lint-license-src : lint-reuse-src

# [EOF]
