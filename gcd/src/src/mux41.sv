module mux41(
  input  logic [3:0] in0,
  input  logic [3:0] in1,
  input  logic [3:0] in2,
  input  logic [3:0] in3,
  input  logic [1:0] sel,
  output logic [3:0] out
);

always_comb begin
  case (sel)
    2'b11: out = in3;
    2'b10: out = in2;
    2'b01: out = in1;
    2'b00: out = in0;
  endcase
end

endmodule: mux41
