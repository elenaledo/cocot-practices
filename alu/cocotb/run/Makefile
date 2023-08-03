# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

TOPLEVEL_LANG ?= verilog

PWD=$(shell pwd)
export PYTHONPATH := $(PWD)/../env:$(PYTHONPATH)
export PYTHONPATH := $(PWD)/../tests/sequence:$(PYTHONPATH)

ifeq ($(TOPLEVEL_LANG),verilog)
	VERILOG_SOURCES += $(PWD)/../../src/add.sv
	VERILOG_SOURCES += $(PWD)/../../src/sub.sv
	VERILOG_SOURCES += $(PWD)/../../src/alu.sv
else ifeq ($(TOPLEVEL_LANG),vhdl)
  VHDL_SOURCES = $(shell pwd)/dff.vhdl
endif

#.PHONY add:
#	$(MAKE) sim MODULE=test_add TOP_LEVEL=add
#.PHONY sub:
#	$(MAKE) sim MODULE=test_sub TOP_LEVEL=sub
.PHONY: all
all:
	make alu
.PHONY: alu
alu:
	@$(MAKE) sim MODULE=test_alu TOP_LEVEL=alu
.PHONY: clean
clean::
	@rm -rf simbuild
	@rm -f *.vcd
	@rm -f *.xml

include $(shell cocotb-config --makefiles)/Makefile.sim
