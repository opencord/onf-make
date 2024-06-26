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
# Intent:
# -----------------------------------------------------------------------
# NOTE: The doc8 command runs recursively on directories so targets
#       *-mod and *-src are not yet supported.
# -----------------------------------------------------------------------

##--------------------##
##---]  INCLUDES  [---##
##--------------------##
include $(onf-mk-dir)/lint/robot/robot.mk
# include $(onf-mk-dir)/lint/robot/excl.mk
include $(onf-mk-dir)/lint/robot/help.mk
include $(onf-mk-dir)/lint/robot/install.mk

# [EOF]
