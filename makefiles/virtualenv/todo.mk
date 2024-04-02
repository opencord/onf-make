# -*- makefile -*-
## -----------------------------------------------------------------------
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
virtualenv-todo ::

	$(call banner-enter,$@)

	@printf '\n[TODO]\n'
	@printf '  * Refactor include.mk into a simple primary include file for the directory.\n'
	@printf '  * Extract venv patch logic into a separate makefile.\n'
	@printf '  * docs.voltha.org: document makefile, targets & behavior.\n'
	@printf '\n'

	$(call banner-leave,$@)

todo :: virtualenv-todo

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
