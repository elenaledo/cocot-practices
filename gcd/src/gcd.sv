module gcd (
  input  logic       clk,
  input  logic [3:0] a,
  input  logic [3:0] b,
  input  logic [1:0] a_sel,
  input  logic       b_sel,
  input  logic       a_en,
  input  logic       b_en,
  output logic [3:0] gcd_o,
  output logic       b_zero,
  output logic       a_lt
);

  logic [3:0] A;
  logic [3:0] B;
  logic [3:0] subab;
  logic [3:0] outa;
  logic [3:0] outb;
/* verilator lint_off PINCONNECTEMPTY */
  mux41 muxa(
  .in0(a),
  .in1(B),
  .in2(subab),
  .in3(),
  .sel(a_sel),
  .out(outa)
  );
/* verilator lint_on PINCONNECTEMPTY */
  mux21 muxb(
  .in0(b),
  .in1(A),
  .sel(b_sel),
  .out(outb)
  );
  dff a_ff(
  .clk(clk),
  .en(a_en),
  .d(outa),
  .q(A)
  );
  dff b_ff(
  .clk(clk),
  .en(b_en),
  .d(outb),
  .q(B)
  );
  assign b_zero = (B==0)?1:0;
  assign a_lt   = (A<B)?1:0;
  assign subab  = (A + ~B + 1'b1);
  assign gcd_o  = A;
endmodule: gcd
