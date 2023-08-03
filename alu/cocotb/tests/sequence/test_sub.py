# This file is public domain, it can be freely copied without restrictions.
# SPDsub_result-License-Identifier: CC0-1.0
# Simple tests for an sub module
import os
import random
import sys
from pathlib import Path

import cocotb
from cocotb.runner import get_runner
from cocotb.triggers import Timer

if cocotb.simulator.is_running():
    from sub_model import sub_model


@cocotb.test()
async def sub_basic_test(dut):
    """Test for 10 - 5"""

    A = 10
    B = 5

    dut.A.value = A
    dut.B.value = B

    await Timer(2, units="ns")

    assert dut.sub_result.value == sub_model(
        A, B
    ), f"Adder result is incorrect: {dut.sub_result.value} != 5"


@cocotb.test()
async def sub_randomised_test(dut):
    """Test for adding 2 random numbers multiple times"""

    for i in range(10):

        A = random.randint(5,10)
        B = random.randint(5,10)

        dut.A.value = A
        dut.B.value = B

        await Timer(2, units="ns")

        assert dut.sub_result.value == sub_model(
            A, B
        ), "Randomised test failed with: {A} - {B} = {sub_result}".format(
            A=dut.A.value, B=dut.B.value, sub_result=dut.sub_result.value
        )


def test_sub_runner():
    """Simulate the sub example using the Python runner.

    This file can be run directly or via pytest discovery.
    """
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "icarus")

    proj_path = Path(__file__).resolve().parent.parent
    # equivalent to setting the PYTHONPATH environment variable
    sys.path.append(str(proj_path / "env"))

    verilog_sources = []
    vhdl_sources = []

    if hdl_toplevel_lang == "verilog":
        verilog_sources = [proj_path / "src" / "sub.sv"]

    # equivalent to setting the PYTHONPATH environment variable
    sys.path.append(str(proj_path / "tests"))

    runner = get_runner(sim)
    runner.build(
        verilog_sources=verilog_sources,
        hdl_toplevel="sub",
        always=True,
    )
    runner.test(hdl_toplevel="sub", test_module="test_sub")


if __name__ == "__main__":
    test_sub_runner()
