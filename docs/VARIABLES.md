make macros
-----------

Sandbox directories
===================

| Varname     | Description                                               |
| ---         | ---                                                       |
| ONF_MAKEDIR | Path to library repo:onf-make/makefiles/ directory        |
| MAKEDIR     | Path to per-repository, local makefiles/ directory.       |
|             |                                                           |
| onf-mk-top  | Path to top level sandbox directory (contains makefiles/) |
| onf-mk-lib  | Path to library repo:onf-make/makefiles/ directory        |
| onf-mk-loc  | Path to per-repository, local makefiles/ directory.       |
| onf-mk-tmp  | Threaded makefile scratch area (cleanup behind yourself!) |

Runtime modes
=============

| Varname | Description                                               |
| ---     | ---                                                       |
| DEBUG   | Enable makefile debugging, display includes while loading |
| VERBOSE | |

Lint Conditionals
=================

| Varname          | Tool     | Description                                  |
| ---              | ---      | ---                                          |
| NO-LINT-DOC8     | text     | Disable reStructured text syntax checking    |
| NO-LINT-FLAKE8   | python   | Disable tool:flake8 syntax checking          |
| NO-LINT-GOLANG   | golang   | Disable tool:gofmt syntax checking           |
| NO-LINT-GROOVY   | groovy   | Disable tool:groovy syntax checking          |
| NO-LINT-JJB      |          | Disable Jenkins Job Builder (JJB) syntax checking |
| NO-LINT-JSON     | json     | Disable config file syntax checking          |
| NO-LINT-MAKEFILE | makefile | Disable tool:make --dryrun, --no-undef syntax checking |
| NO-LINT-PYLINT   | python   | Disable tool:pylint syntax checking          |
| NO-LINT-PYTHON   | python   | Disable all python syntax checking           |
| NO-LINT-REUSE    |          | Disable license checking                     |
| NO-LINT-ROBOT    |          | Syntax check tool:robot test framework       |
| NO-LINT-SHELL    | bash     | Run tool:shellcheck on script sources.       |
| NO-LINT-TOX      |          | Syntax check virtualenv test automation      |
| NO-LINT-YAML     | yaml     | Disable config file syntax checking          |

<!---

# -----------------------------------------------------------------------
# Copyright 2023-2024 Open Networking Foundation Contributors
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
# SPDX-FileCopyrightText: 2023-2024 Open Networking Foundation Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------
# Intent:
# -----------------------------------------------------------------------

--->
