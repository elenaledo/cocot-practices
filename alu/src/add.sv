// This file is public domain, it can be freely copied without restrictions.
// SPDadd_result-License-Identifier: CC0-1.0
// Adder DUT
`timescale 1ns/1ps

module add #(
  parameter integer DATA_WIDTH = 4
) (
  input  logic unsigned [DATA_WIDTH-1:0] A,
  input  logic unsigned [DATA_WIDTH-1:0] B,
  output logic unsigned [DATA_WIDTH:0]   add_result
);

  assign add_result = A + B;

  // Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, adder);
  end

endmodule
