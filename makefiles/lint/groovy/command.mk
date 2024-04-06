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

$(if $(DEBUG),$(warning ENTER))

lint-groovy-cmd := $(call node-get-tool-path,npm-groovy-lint)

# lint-groovy-conf := $(call path-by-makefile,.groovylintrc.json)
lint-groovy-conf := $(onf-mk-dir)/lint/groovy/.groovylintrc.json

lint-groovy-args := $(null)
lint-groovy-args += --config $(lint-groovy-conf)


# lint-groovy-args += --loglevel info
# lint-groovy-args += --ignorepattern
# lint-groovy-args += --verbose

# [EOF]

