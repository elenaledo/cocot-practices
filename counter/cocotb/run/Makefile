# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

TOPLEVEL_LANG ?= verilog

PWD=$(shell pwd)
export PYTHONPATH := $(PWD)/../env:$(PYTHONPATH)
export PYTHONPATH := $(PWD)/../tests:$(PYTHONPATH)

ifeq ($(TOPLEVEL_LANG),verilog)
  VERILOG_SOURCES = $(PWD)/../../src/dff.sv
else ifeq ($(TOPLEVEL_LANG),vhdl)
  VHDL_SOURCES = $(shell pwd)/dff.vhdl
endif
.PHONY: sim
sim:
MODULE = test_dff
TOPLEVEL = dff
.PHONY: clean
clean::
	@rm -rf sim_build
include $(shell cocotb-config --makefiles)/Makefile.sim
