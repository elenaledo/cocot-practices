def alu_model(a: int, b: int, mode: int) -> int:
    result = 0
    if mode: result = a - b
    else: result = a + b
    return result
