# Repository: onf-make

This repo holds generic library makefile logic and targets that
can be used to build and test arbitrary targets.

Two module directories are maintained, access through variables:

Make Macro   | Description
------------ | ---------------------------------------------
MAKEDIR      | Path to project specific makefiles/ directory
ONF_MAKEDIR  | Path to generic library makefiles/ directory

include $(ONF_MAKEDIR)/include.mk
  # implicit project import:
  # include $(MAKEDIR)/include.mk
