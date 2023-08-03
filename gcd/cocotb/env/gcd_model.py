# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

import math
def adder_model(a: int, b: int) -> int:
    """model of adder"""
    int result;
    result = math.gcd(a,b)
    return result
