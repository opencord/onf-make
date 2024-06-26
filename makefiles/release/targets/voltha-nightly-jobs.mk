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
# Intent: Helper makefile target used to setup for a release
# -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

##-------------------##
##---]  GLOBALS  [---##
##-------------------##

## ---------------------------------------------------------------------------
## Intent: Create branch driven nightly test jobs.
##   o Clone config for the last nightly release
##   o In-place edit to the latest version.
## ---------------------------------------------------------------------------
## NOTE: WIP - nightly jobs have not yet migrated from the mega job config file
## ---------------------------------------------------------------------------
voltha-nightly-dir  := $(release-mk-top)/jjb/voltha-test/voltha-nightly-jobs
voltha-nightly-yaml := $(voltha-nightly-dir)/$(voltha-version).yaml
voltha-nightly-tmpl := $(voltha-nightly-dir)/$(voltha-release-last).yaml

create-jobs-release-nightly : $(voltha-nightly-yaml)
$(voltha-nightly-yaml) : $(voltha-nightly-tmpl)

	@echo
	@echo "** Create branch driven pipeline: nightly tests"
	sed -e 's/$(last-release)/$(voltha-version)/g' $< > $@
	$(HIDE)/bin/ls -l $(dir $@)

## ---------------------------------------------------------------------------
## Intent: Create branch driven nightly test jobs.
## ---------------------------------------------------------------------------
$(voltha-nightly-tmpl):
	@echo "ERROR: Yaml template branch does not exist: $@"
	@echo 1

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
