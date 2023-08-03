// This file is public domain, it can be freely copied without restrictions.
// SPDX-License-Identifier: CC0-1.0


module dff (
  input logic clk,
  input logic en,
  input logic [3:0] d,
  output logic[3:0] q
);

always @(posedge clk) begin
  if(en)
  q <= d;
end

endmodule: dff
