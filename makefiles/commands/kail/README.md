# -----------------------------------------------------------------------
# Workaround for godownloader disappearing:
#   This is a complete hack to get bbsim and v-s-t functional again.
#   A more permanent answer is needed, copy binaries into a *tool* repo
#   and use directly from git clone w/o access or install overhead.
# ----------------------------------------------------------------------

1) Retrieve an archived copy of the script and place in v-s-t/etc.
   https://searchcode.com/file/316605398/godownloader.sh
2) A few script edits are needed:
     o change download method from curl to wget.
     o VERSION= variable requires a 'v' prefix.
3) Update Makefile to install the new command.

# [EOF]

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
