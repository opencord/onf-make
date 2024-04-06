NVM / Node Package Manager
==========================

Makefiles beneath node-js/ maintain nvm and node package installs.

Directories:

- $(sandbox)/.tmp
  - $(sandbox)/.tmp/.nvm
  - $(sandbox)/.tmp/node_modules

| Command | Description |
| ------- | ----------- |
| make npm-groovy-lint | Install the groovy linting tool  |
| make sterile         | Remove .tmp/{.nvm, node_modules} |

nvm/install.sh
--------------

Install script is downloaded from an external source so makefile targets
at present are only intended for interactive use.  Install script could
be checked in and trusted packages proxied but a review of copyrights,
etc need to happen first.

Node Packages in use:
---------------------

- npm-groovy-lint

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
