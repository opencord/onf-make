# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2017-2024 Open Networking Foundation Contributors
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

## -----------------------------------------------------------------------
## Intent: Display target help
## -----------------------------------------------------------------------
help ::
	@printf '  %-33.33s %s\n' 'lf-tempdir(-help)' \
	  'Create a temp directory for internal makefile use'

## -----------------------------------------------------------------------
## Intent: Display extended target help
## -----------------------------------------------------------------------
lf-tempdir-help:
	@printf 'Usage: make [options] [target] ...\n'
	@printf '  %-33.33s %s\n' 'lf-mk-tmp-create' \
	  'Create a temporary directory (dependency driven)'
	@printf '  %-33.33s %s\n' 'lf-mk-meta-create' \
	  'Create a directory for tempdir timestamp tracking'
	@printf '  %-33.33s %s\n' 'lf-mk-todo' \
	  'Display a list of enhancements for the target'

	@printf '\n[VARS]\n'
	@printf '  %-33.33s %s\n' '  lf-mk-tmp=' \
	  'Temp directory path'
	@printf '  %-33.33s %s\n' '  lf-mk-tmp-name=' \
	  'Temp directory basename'
	@printf '  %-33.33s %s\n' '  lf-mk-user-meta=' \
	  'Per-user timestamp and resource directory (internal)'
	@printf '  %-33.33s %s\n' '  lf-mk-user-mktemp=' \
	  'Per-user temp directory paths (one per invocation)'

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
# todo-all += lf-mk-todo
lf-mk-todo ::

	$(call banner-enter,$@)

	@printf '\n[TODO]\n'
	@printf '  * Replace lf/include.mk macro onf-mk-tmp= with lf-mk-tmp=\n'
	@printf '  * Create a BATS unit test for tempdir creation\n'
	@printf '  * Document makefile targets and behavior on docs.voltha.org\n'
	@printf '\n'

	$(call banner-leave,$@)

# [EOF]
