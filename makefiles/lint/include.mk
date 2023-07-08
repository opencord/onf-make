# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2022 Open Networking Foundation (ONF) and the ONF Contributors
# -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

help ::
	@echo
	@echo "[LINT]"

include $(ONF_MAKEDIR)/lint/groovy.mk
include $(ONF_MAKEDIR)/lint/jjb.mk
include $(ONF_MAKEDIR)/lint/json.mk
include $(ONF_MAKEDIR)/lint/license/include.mk
include $(ONF_MAKEDIR)/lint/makefile.mk
include $(ONF_MAKEDIR)/lint/python.mk
include $(ONF_MAKEDIR)/lint/shell.mk
include $(ONF_MAKEDIR)/lint/yaml.mk

include $(ONF_MAKEDIR)/lint/help.mk

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
