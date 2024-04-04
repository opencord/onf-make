doc8
====

The doc8 tool can be configured by modifying doc8.ini files.
Common config changes can be added in repo:onf-make/makefiles/lint/doc8.
per-repository changes can be added in lf/local/makefiles/lint/doc8/doc8.ini.

The makefile target lint-doc8 will merge these two config files into
a single config prior to invoking the doc8 tool.

Common exclusions are added in repo:onf-make/makefiles/lint/doc8/doc.ini.

[TODO]
  - Deploy repo:onf-make to all voltha repositories.
  - Create lf/local/lib/makefiles/doc8/doc.ini and configure.
  - Once all repositories have been updated delete lint/doc8/excl.mk

<!---

# -----------------------------------------------------------------------
# Copyright 2024 Open Networking Foundation Contributors
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
# SPDX-FileCopyrightText: 2024 Open Networking Foundation Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------
# Intent:
# -----------------------------------------------------------------------

--->
