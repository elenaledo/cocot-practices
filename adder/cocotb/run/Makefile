TOPLEVEL_LANG ?= verilog

PWD=$(shell pwd)

export PYTHONPATH := $(PWD)/../env:$(PYTHONPATH)
export PYTHONPATH := $(PWD)/../tests:$(PYTHONPATH)

ifeq ($(TOPLEVEL_LANG),verilog)
    VERILOG_SOURCES = $(PWD)/../../src/f_adder.sv
else ifeq ($(TOPLEVEL_LANG),vhdl)
    VHDL_SOURCES = $(PWD)/../src/adder.vhdl
else
    $(error A valid value (verilog or vhdl) was not provided for TOPLEVEL_LANG=$(TOPLEVEL_LANG))
endif

TOPLEVEL := f_adder
MODULE   := test_adder

include $(shell cocotb-config --makefiles)/Makefile.sim
