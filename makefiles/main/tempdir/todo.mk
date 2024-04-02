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
## Intent: Display a list of future enhancements
## -----------------------------------------------------------------------
lf-mk-todo ::

	$(call banner-enter,$@)

	@printf '\n[TODO]\n'
	@printf '  * Replace lf/include.mk macro onf-mk-tmp= with lf-mk-tmp=\n'
	@printf '  * Create a BATS unit test for tempdir creation\n'
	@printf '    + make lf-tempdir; ls /tmp/repo-LF*\n'
	@printf '    + make lf-tempdir clean; ls /tmp/repo-LF*\n'
	@printf '  * Document makefile targets and behavior on docs.voltha.org\n'
	@printf '\n'

	$(call banner-leave,$@)

todo :: lf-mk-todo

# [EOF]
