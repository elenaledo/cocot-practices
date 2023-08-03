// This file is public domain, it can be freely copied without restrictions.
// SPDX-License-Identifier: CC0-1.0


module rdff (
  input logic clk,
  input logic rst,
  input logic [1:0] d,
  output logic[1:0] q
);

always @(posedge clk) begin
  if(!rst)
  q <= d;
  else
  q <= 0;
end

endmodule: rdff
