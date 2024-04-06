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

$(if $(DEBUG),$(warning ENTER))

## -----------------------------------------------------------------------
## Intent: Display topic help
## -----------------------------------------------------------------------
help-summary ::
	@printf '  %-33.33s %s\n' 'lint-groovy'      'Syntax check sources'
	@printf '  %-33.33s %s\n' 'lint-groovy-help' 'Extended target help'

## -----------------------------------------------------------------------
## Intent: Display extended topic help
## -----------------------------------------------------------------------
.PHONY: lint-groovy-help
lint-groovy-help ::
	@printf '  %-33.33s %s\n' 'lint-groovy-all' 'Lint all available sources'
	@printf '  %-33.33s %s\n' 'lint-groovy-mod' 'Lint locally modified (git status)'
	@printf '  %-33.33s %s\n' 'lint-groovy-src' 'Lint individually (GROOVY_SRC=...)'

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
