# -*- makefile -*-
# -----------------------------------------------------------------------
# Copyright 2017-2024 Open Networking Foundation Contributors
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
# SPDX-FileCopyrightText: 2017-2024 Open Networking Foundation Contributors
# SPDX-License-Identifier: Apache-2.0
# -----------------------------------------------------------------------
# Intent:
# -----------------------------------------------------------------------

$(if $(DEBUG),$(warning ENTER))

# ------------------- ##
# ---]  GLOBALS  [--- ##
# ------------------- ##
VOLTHA_TOOLS_VERSION ?= 2.4.0

# -------------------- ##
# ---]  INCLUDES  [--- ##
# -------------------- ##
# include $(onf-mk-dir)/docker/help.mk

# -----------------------------------------------------------------------
# Load per-repository config: docker mount points, etc
# -----------------------------------------------------------------------
include $(firstword $(wildcard \
  $(local-mk-dir)/docker/config/include.mk \
  $(onf-mk-dir)/docker/config/$(--repo-name--).mk \
))

# ---------------------------------
# Induce error for misconfiguration
# ---------------------------------
go-cobertura-docker-mount ?= $(error go-cobertura-docker-mount= is required)
protoc-sh-docker-mount    ?= $(error protoc-sh-docker-mount= is required)

# ---------------------------
# Macros: command refactoring
# ---------------------------
docker-iam     ?= --user $$(id -u):$$(id -g)#          # override for local use
docker-run     = docker run --rm $(docker-iam)#        # Docker command stem
docker-run-is  = $(docker-run) $(is-stdin)#            # Attach streams when interactive
docker-run-app = $(docker-run-is) -v ${CURDIR}:/app#   # w/filesystem mount

# -----------------------------------------------------------------------
# --interactive: Attach streams when stdout (fh==0) defined
# --tty        : Always create a pseudo-tty else jenkins:docker is silent
# -----------------------------------------------------------------------
is-stdin       = $(shell test -t 0 && { echo '--interactive'; })
is-stdin       += --tty

# Docker volume mounts: container:/app/release <=> localhost:{pwd}/release
vee-golang     = -v gocache-${VOLTHA_TOOLS_VERSION}:/go/pkg
vee-citools    = voltha/voltha-ci-tools:${VOLTHA_TOOLS_VERSION}

# ---------------
# Tool Containers
# ---------------
docker-go-stem = $(docker-run-app) -v gocache:/.cache $(vee-golang) $(vee-citools)-golang

# -----------------------------------------------------------------------
# Usage: GO := $(call get-cmd-docker-go)
# -----------------------------------------------------------------------
get-cmd-docker-go = $(docker-go-stem) go
GO                ?= $(call get-cmd-docker-go)

# -----------------------------------------------------------------------
# Usage: GO_SH := $(call get-docker-go-sh,./my.env.temp)
#    - populate my.env.temp with shell content to pass in
# -----------------------------------------------------------------------
get-cmd-docker-go-sh = $(docker-go-stem) $(if $(1),--env-file $(1)) sh -c
GO_SH                ?= $(call get-cmd-docker-go-sh,./my.env.temp)

# -----------------------------------------------------------------------
# Usage: PROTOC := $(call get-cmd-docker-protoc)
# -----------------------------------------------------------------------
get-cmd-docker-protoc = $(docker-run-app) $(vee-citools)-protoc protoc
PROTOC                ?= $(call get-cmd-docker-protoc)

# -----------------------------------------------------------------------
# Intent: Construct docker command passing in mounts.
#         To override, declare PROTOC_SH := $(call ) in Makefile
# -----------------------------------------------------------------------
# Usage:
#   docker-argv-mounts += -v ${CURDIR}:$(protoc-sh-docker-mount)
#   docker-argv-mounts += --workdir $(protoc-sh-docker-mount)
#   PROTOC_SH := $(call get-cmd-docker-argv-protoc-sh,docker-argv-mounts)
# -----------------------------------------------------------------------
get-cmd-docker-argv-protoc-sh =\
  $(strip \
    $(foreach argv,$(1),\
      $(docker-run-is) $(if $(argv),$($(argv))) $(vee-citools)-protoc sh -c \
    )\
)

# -----------------------------------------------------------------------
# Intent: Original get-cmd-docker library function.
#   - conditional mount: use -v or --workdir
#   - See Also: get-cmd-docker-argv-protoc-sh() for generalized mounts
# -----------------------------------------------------------------------
# Usage: PROTOC_SH := $(call get-cmd-docker-argv-protoc-sh)
# -----------------------------------------------------------------------
get-cmd-docker-protoc-sh =\
  $(strip \
	$(docker-run-is) \
	  $(if $(protc-sh-docker-mount),               \
		-v ${CURDIR}:$(protoc-sh-docker-mount) \
		--workdir=$(protoc-sh-docker-mount)    \
	  ) \
	  $(vee-citools)-protoc \
	  sh -c \
  )
PROTOC_SH ?= $(call get-cmd-docker-protoc-sh)

## -----------------------------------------------------------------------
## Coverage report: junit
## -----------------------------------------------------------------------
## Usage: GO_JUNIT_REPORT ?= $(call get-go-junit-report-cmd)
## -----------------------------------------------------------------------
get-go-junit-report-cmd =\
  $(strip \
	$(docker-run) \
	  -v ${CURDIR}:/app \
	  -i $(vee-citools)-go-junit-report go-junit-report \
  )
GO_JUNIT_REPORT ?= $(call get-go-junit-report-cmd)

## -----------------------------------------------------------------------
## Coverage report: cobertura
## -----------------------------------------------------------------------
## Usage: GOCOVER_COBERTURA ?= $(call get-docker-gocover-cobertura-cmd)
## -----------------------------------------------------------------------
get-docker-go-cobertura-cmd =\
  $(strip \
	$(docker-run)\
	  -v ${CURDIR}:$(go-cobertura-docker-mount)\
	  -i $(vee-citools)-gocover-cobertura gocover-cobertura\
  )
GOCOVER_COBERTURA ?= $(call get-docker-go-cobertura-cmd)

## -----------------------------------------------------------------------
##
## -----------------------------------------------------------------------
get-cmd-docker-golangci-lint =\
  $(strip \
	$(docker-run-app) \
	  -v gocache:/.cache \
	  $(vee-golang)\
	  $(vee-citools)-golangci-lint\
	  golangci-lint\
  )
GOLANGCI_LINT ?= $(call get-cmd-docker-golangci-lint)

## -----------------------------------------------------------------------
##
## -----------------------------------------------------------------------
get-docker-hadolint =\
  $(strip \
	$(docker-run-app)         \
	  $(vee-citools)-hadolint \
	  hadolint                \
  )
HADOLINT ?= $(call get-docker-hadolint)

$(if $(DEBUG),$(warning LEAVE))

# [EOF]
