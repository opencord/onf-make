# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2022-2023 Open Networking Foundation (ONF) and the ONF Contributors
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
# SPDX-FileCopyrightText: 2022-2023 Open Networking Foundation (ONF) and the ONF Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------
# https://gerrit.opencord.org/plugins/gitiles/onf-make
# ONF.makefile.version = 1.0
# -----------------------------------------------------------------------

ifndef mk-include--onf-commands # guard macro, include once

  $(if $(DEBUG),$(warning ENTER))
  include $(onf-mk-dir)/commands/kail/include.mk
  include $(onf-mk-dir)/commands/kubectl/include.mk
  include $(onf-mk-dir)/commands/pre-commit/include.mk
  include $(onf-mk-dir)/commands/tox/include.mk
  $(if $(DEBUG),$(warning LEAVE))

help ::
	@printf '  %-33.33s %s\n' 'commands-help' \
	  'Display verbose help for targets makefiles/commands/*'

  mk-include--onf-commands := true

endif # mk-include--onf-commands

# [EOF]
