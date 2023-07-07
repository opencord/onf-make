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


## config.mk

Config.mk contains flags that will {en,dis}able conditional makefile logic.

- Disable unsupported lint targets for checking source or copyrights.
- Enable makefile features or per-repository special snowflake logic.
- Define common flags and values: repo-name = foo
- Define debugging flags, DEBUG=, VERBOSE=, DEBUG*=

## Hierarchy

── [mM]akefile
├── config.mk
├── makefiles/

Basic makefile hierarchy contains:
  - At least one {mM}akefile in the repository root directory.
  - Optional config.mk file to define makefile behavior.
  - A makefiles/ directory containing library logic

For each subdir in the makefiles library the file include.mk exists

├── makefiles
│   ├── include.mk
│   ├── docker
│   │   └── include.mk
│   ├── etc
│   │   └── include.mk
│   ├── help
│   │   ├── include.mk
│   ├── lint
│   │   │   ├── include.mk
│   │   │   └── reuse.mk

include.mk will capture and normalize access for target logic.
One single include to define all permutations for a makefile target.

# Special Snowflakes / Custom Target Logic

% onf-make/makefiles
├── lint
│   ├── license
│   │   ├── include.mk
│   │   ├── license-check.sh
│   │   ├── license-helper.sh
│   │   ├── reuse.mk
│   │   ├── voltha-onos.mk    <-----**
│   │   └── voltha-protos.mk  <-----**

Some repositories contain custom logic and scripts attached to a target.
To help support variants and create a bridge for refactoring, a custom
makefile named for a repository can be supported

- For example the lint-license target can be customized

  - Target:lint-license is a dependency of target=lint
  - Create makefiles/lint/license/{repo-name}.mk

    - Define repository-name in config.mk

  - Modify lint/license/include.mk to

    - (hyphen-prefix)include $(MAKEDIR)/lint/license/${repo-name}.mk
    - repo-name.mk when included will define a makefile directive.
    - This directive will inhibit definition of library lint-license targets
    - or a better answer to fully suport display of help targets
    - Include lib makefiles but inhibit processing other lint-license targets.