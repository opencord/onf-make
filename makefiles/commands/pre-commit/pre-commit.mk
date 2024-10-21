# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2022-2024 Open Networking Foundation (ONF) Contributors
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
#
# SPDX-FileCopyrightText: 2022-2024 Open Networking Foundation Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

## -----------------------------------------------------------------------
## Intent: Invoke the pre-commit command
## -----------------------------------------------------------------------
.PHONY: pre-commit
pre-commit : pre-commit-install
	$(activate) && pre-commit

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
commands-help :: pre-commit-help

.PHONY: pre-commit-help
pre-commit-help ::
	@printf '  %-33.33s %s\n' 'pre-commit-install' \
	  'Invoke the pre-commit hook linting tool'

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
