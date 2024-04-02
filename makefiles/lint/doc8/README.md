doc8
====

The doc8 tool can be configured by modifying doc8.ini files.
Common config changes can be added in repo:onf-make/makefiles/lint/doc8.
per-repository changes can be added in lf/local/makefiles/lint/doc8/doc8.ini.

The makefile target lint-doc8 will merge these two config files into
a single config prior to invoking the doc8 tool.

Common exclusions are added in repo:onf-make/makefiles/lint/doc8/doc.ini.

[TODO]
  - Deploy repo:onf-make to all voltha repositories.
  - Create lf/local/lib/makefiles/doc8/doc.ini and configure.
  - Once all repositories have been updated delete lint/doc8/excl.mk

