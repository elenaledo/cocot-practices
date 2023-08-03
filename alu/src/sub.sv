`timescale 1ns/1ps

module sub #(
  parameter integer DATA_WIDTH = 4
) (
  input  logic unsigned [DATA_WIDTH-1:0] A,
  input  logic unsigned [DATA_WIDTH-1:0] B,
  output logic unsigned [DATA_WIDTH:0]   sub_result
);

  assign sub_result = A - B;

  // Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, adder);
  end

endmodule
