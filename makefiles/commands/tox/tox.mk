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

tox-python-versions += py310
tox-python-versions += py3.11.6

tox-args += $(addprefix -e$(space),$(tox-python-versions))

## -----------------------------------------------------------------------
## Intent: Invoke the tox command
## -----------------------------------------------------------------------
tox run-tox : tox-version
	$(activate) && tox $(tox-args)

## -----------------------------------------------------------------------
## Intent: Revert to a pristine state
## -----------------------------------------------------------------------
sterile ::
	$(RM) -r .tox#       # $(TOP)/.tox

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
help ::
	@printf '  %-33.33s %s\n' 'tox' \
	  'Invoke tox (python test automation)'
	@printf '  %-33.33s %s\n' 'tox-help' \
	  'Display extended target help (tox-*)'

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
tox-help ::
	@printf '  %-33.33s %s\n' 'tox-run' \
	  'Self documenting alias for command tox'

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
