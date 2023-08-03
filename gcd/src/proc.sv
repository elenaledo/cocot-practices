module proc(
  input  logic       clk,
  input  logic       rst,
  input  logic [3:0] a,
  input  logic [3:0] b,
  input  logic       avail,
  input  logic       req,
  output logic       busy,
  output logic       valid,
  output logic [3:0] gcd
);

logic [1:0] a_sel;
logic       b_sel;
logic       a_en, b_en;
logic       b_zero, a_lt;

gcd cal(
  .clk(clk),
  .a(a),
  .b(b),
  .a_sel(a_sel),
  .b_sel(b_sel),
  .a_en(a_en),
  .b_en(b_en),
  .gcd_o(gcd),
  .b_zero(b_zero),
  .a_lt(a_lt)
);

ctrlunit control(
  .clk(clk),
  .rst(rst),
  .req(req),
  .avail(avail),
  .b_zero(b_zero),
  .a_lt(a_lt),
  .muxa(a_sel),
  .muxb(b_sel),
  .a_en(a_en),
  .b_en(b_en),
  .busy(busy),
  .valid(valid)
);

endmodule: proc
