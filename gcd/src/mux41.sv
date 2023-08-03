module mux41(
  input  logic [3:0] in0,
  input  logic [3:0] in1,
  input  logic [3:0] in2,
  input  logic [3:0] in3,
  input  logic [1:0] sel,
  output logic [3:0] out
);

assign out = sel[1]?(sel[0]?in3:in2):(sel[0]?in1:in0);

endmodule: mux41
