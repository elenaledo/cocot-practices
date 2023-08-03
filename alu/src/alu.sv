module alu(
  input logic  [3:0] a,
  input logic  [3:0] b,
  input logic        mode,
  output logic [4:0] result
);

logic [4:0] sub_o;
logic [4:0] add_o;

add adder(
  .A(a),
  .B(b),
  .add_result(add_o)
);
sub subtract(
  .A(a),
  .B(b),
  .sub_result(sub_o)
);

assign result = mode?sub_o:add_o;

  // Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, alu);
  end
endmodule : alu
