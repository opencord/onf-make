onf-make library makefiles
==========================

This repository contains common makefile logic and targets that can be
used to build arbitrary repositories.  Makefile logic is currently being
consumed by the VOLTHA project

makefiles/ subdirectories
-------------------------

Two distinct sets of makefiles are needed to support builds:

- The first is a subdir of makefiles/ named 'onf-make'
    - This directory exists and is maintained as a git-submodule
      of [repo:onf-make](https://github.com/opencord/onf-make).
    - Library makefiles contain independent logic to install common
      tools such as (virtualenv), perform linting tasks, define constants
      and perform path/string manipulation, etc.

- The second makefile directory contains repository/project specific logic:

    - makefiles/local/ exists as a repository subdirectory under SCM.
    - Contains custom targets, variant parameters and custom logic
      specific to the repository it exists within.

- Most makefile logic can be parameterized and implemented to support
  reuse.  Consider adding enhancements or refactoring local/ makefile
  logic into [repo:onf-make](https://github.com/opencord/onf-make) so
  all makefiles can leverage it.

Hierarchy
---------

    % tree --charset=ascii -n

    Makefile
    config.mk
    makefiles/
    |-- include.mk
    |-- local
    |   |-- include.mk
    |   |   |   |-- doc8
    |   |   |   |    |-- doc8.ini   (alas only one --config switch allowed)
    |-- [onf-make: git-submodule](https://github.com/opencord/onf-make)
    |   |-- makefiles
    |   |   |-- consts.mk
    |   |   |-- include.mk
    |   |   |-- lint
    |   |   |   |-- doc8            Syntax check ReStructuredText (rst) files
    |   |   |   |-- groovy
    |   |   |   |-- python
    |   |   |   |-- robot.mk        Syntax check robot testing framework
    |   |   |   |-- shell.mk        Invoke shellcheck command on scripts
    |   |   |   |-- yaml            Syntax check yaml configs

NOTES
=====

- Ascii art was rendered using

    - tree --charset=ascii -n

- README.md can be rendered locally using

    - pandoc README.md | lynx -stdin
    - make view

SEE ALSO
========

- [Makefile Variables & Debugging](docs/VARIABLES.md)
- [Todo List](docs/todo.md)

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
