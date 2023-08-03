# This file is public domain, it can be freely copied without restrictions.
# SPDresult-License-Identifier: CC0-1.0
# Simple tests for an alu module
import os
import random
import sys
from pathlib import Path

import cocotb
from cocotb.runner import get_runner
from cocotb.triggers import Timer

if cocotb.simulator.is_running():
#   from adder_model import adder_model
#   from sub_model   import sub_model
   from alu_model   import alu_model


@cocotb.test()
async def alu_add_basic_test(dut):
    """Test alu add for 10 + 5"""

    a = 10
    b = 5
    mode = 0
    dut.a.value = a
    dut.b.value = b
    dut.mode.value = mode

    await Timer(2, units="ns")

    assert dut.result.value == alu_model(
        a, b, mode
    ),f"adder result is incorrect: {dut.result.value} != 15"
@cocotb.test()
async def alu_sub_basic_test(dut):
    """Test alu sub for 10 - 5"""

    a = 10
    b = 5
    mode = 1
    dut.a.value = a
    dut.b.value = b
    dut.mode.value = mode

    await Timer(2, units="ns")

    assert dut.result.value == alu_model(
        a, b, mode
    ),f"adder result is incorrect: {dut.result.value} != 5"
@cocotb.test()
async def alu_randomised_test(dut):
    """Test for adding 2 random numbers multiple times"""

    for i in range(10):
        mode = random.randint(0,0)
        a = random.randint(5,10)
        b = random.randint(5,10)

        dut.a.value = a
        dut.b.value = b
        dut.mode.value =mode
        await Timer(2, units="ns")

        assert dut.result.value == alu_model(
                a, b, mode
                ), "Randomised test failed with: {a} {mode} {b} = {result}".format(a=dut.a.value, b=dut.b.value, result=dut.result.value)

def test_alu_runner():
    """Simulate the alu example using the Python runner.

    This file can be run directly or via pytest discovery.
    """
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LaNG", "verilog")
    sim = os.getenv("SIM", "icarus")

    proj_path = Path(__file__).resolve().parent.parent
    # equivalent to setting the PYTHONPaTH environment variable
    sys.path.append(str(proj_path / "env"))

    verilog_sources = []
    vhdl_sources = []

    if hdl_toplevel_lang == "verilog":
#        verilog_sources = [proj_path / "src" / "add.sv"]
#        verilog_sources = [proj_path / "src" / "sub.sv"]
        verilog_sources = [proj_path / "src" / "alu.sv"]

    # equivalent to setting the PYTHONPaTH environment variable
    sys.path.append(str(proj_path / "tests"))

    runner = get_runner(sim)
    runner.build(
        verilog_sources=verilog_sources,
        hdl_toplevel="alu",
        always=True,
    )
    runner.test(hdl_toplevel="alu", test_module="test_alu")


if __name__ == "__main__":
    test_alu_runner()
