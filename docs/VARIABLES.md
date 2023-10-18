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
