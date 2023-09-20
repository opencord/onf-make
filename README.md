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
    - Makefile directory contains independent logic to install common
      tools such as (virtualenv), perform linting tasks, define constants
      and perform path/string manipulation, etc.
- The second makefile directory contains repository specific logic

    - Exists as a repository subdirectory named makefiles/local/.
    - Contains custom targets, variant parameters and custom logic
      specific to the repository it exists within.

- Most makefile logic can be parameterized and implemented to support
  reuse.  Consider adding enhancements or refactoring local/ makefile
  logic into [repo:onf-make](https://github.com/opencord/onf-make) so
  all makefiles can leverage the logic.

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
  
TODO
====

- Refactor and merge logic from available repository makefiles/ directories.
- Update to make use of library makefiles

    - [setup.sh](http://github.com/opencord/onf-make/blob/master/bin/setup.sh)
    - {repository}/makefiles/{local, onf-make}/
    - Create [config.mk](https://github.com/opencord/onf-make/blob/master/config.mk) to enable targets and features.

- Exercise make lint targets, bulk cleanup is needed across all repositories.

NOTES
=====

- Ascii art was rendered using

    - tree --charset=ascii -n

- README.md can be rendered locally using

    - pandoc README.md | lynx -stdin
