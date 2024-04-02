# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2017-2024 Open Networking Foundation (ONF) Contributors
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
# SPDX-FileCopyrightText: 2017-2024 Open Networking Foundation Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------
# Intent: This makefile is intended for extremely limited use:
#   o A temp directory is created for internal makefile use.
#   o Installers, downloads, etc.
#   o Allowing garbage to persist in /tmp is not desirable behavior.
#   o Create breadcrumbs for the sterile target to find and remove later.
# -----------------------------------------------------------------------

##-------------------##
##---]  GLOBALS  [---##
##-------------------##
lf-mk-tmp      := $(shell mktemp --directory -t 'repo-LF-make.XXXXXXXXXX')
lf-mk-tmp-name := $(notdir $(lf-mk-tmp))

lf-mk-user-meta   ?= $(dir $(lf-mk-tmp)/)$(USER).mk.meta
lf-mk-user-mktemp ?= $(lf-mk-user-meta)/mktemp

lf-mk-tmp-create  := $(lf-mk-tmp)/.exists
lf-mk-meta-create := $(lf-mk-user-mktemp)/$(lf-mk-tmp-name)

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
.PHONY: lf-tempdir
lf-tempdir : lf-mk-meta-create

## -----------------------------------------------------------------------
## Intent: Create tempdir
##   o Create a temp directory
##   o Create a timestamp file to record time of creation
## -----------------------------------------------------------------------
.PHONY: lf-mk-tmp-create
lf-mk-tmp-create : $(lf-mk-tmp-create)
$(lf-mk-tmp-create) :

	$(if $(DEBUG),$(call banner-enter,$@))
	@mkdir -p $(dir $@)
	@touch $@
	$(if $(DEBUG),$(call banner-leave,$@))

## -----------------------------------------------------------------------
## Intent: Create a timestamp file for temp directory cleanup:
##   o Create a storage directory
##   o Record timestamp file used by temp directory creation
## -----------------------------------------------------------------------
.PHONY: lf-mk-meta-create
lf-mk-meta-create : lf-mk-tmp-create $(lf-mk-meta-create)
$(lf-mk-meta-create) :

	$(if $(DEBUG),$(call banner-enter,$@))
	@mkdir -p $(dir $@)
	@printf "$(lf-mk-tmp-create)" >> "$(lf-mk-user-mktemp)/$(lf-mk-tmp-name)"
	$(if $(DEBUG),$(call banner-leave,$@))

## -----------------------------------------------------------------------
## Intent: Remove temp directories created by a makefile run.
##   o Automated directory cleanup is not easily supported by make.
##   o Use breadcrumbs dropped during tempdir creation for removal.
##   o Only consider subdirs older than the current makefile run.
##   o Only consider subdirs older than +n days (persistent cron jobs).
## -----------------------------------------------------------------------
sterile-timestamp = $(shell date '+%Y-%m-%d' -d '3 days ago')
sterile ::

    # Create a reference file to remove lingering stale directories
	$(HELP)touch --date "$(sterile-timestamp)" "$(lf-mk-tmp-create)-stale"

	$(HIDE)find '$(dir $(lf-mk-tmp))' -maxdepth 1 -name 'repo-LF-make*' -type d -print0 \
	   | $(xargs-cmd0) -I'{}' find {} -name '.exists' -not -newer "$(lf-mk-tmp-create)-stale" -print0 \
	   | $(xargs-n1-clean) dirname --zero \
	   | $(xargs-n1-clean) $(RM) -vr

    # Remove late: target dep (sterile : clean) would remove breadcrumbs
	@$(MAKE) --no-print-directory clean

## -----------------------------------------------------------------------
## Intent : Remove mktemp for the current invocation
## -----------------------------------------------------------------------
clean ::
	$(RM) -r "$(lf-mk-tmp)"

# [EOF]
