# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2023 Open Networking Foundation (ONF) and the ONF Contributors
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

.PHONY: help clean help test
.DEFAULT_GOAL := help

##-------------------##
##---]  GLOBALS  [---##
##-------------------##
TOP          ?= .
MAKEDIR      ?= $(TOP)/makefiles

# ONF_MAKEDIR   ?= $(HOME)/repo/onf-make/makefiles
# include $(ONF_MAKEDIR)/include.mk

##--------------------##
##---]  INCLUDES  [---##
##--------------------##
include config.mk#                # configure
include $(MAKEDIR)/include.mk     # top level include

## Display make help text late
include $(ONF_MAKEDIR)/help/trailer.mk

# [EOF]
