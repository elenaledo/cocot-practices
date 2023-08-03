//-------------------------------------------------------------------------------------
// Module name: Fadd_sub
// Description: Addition & Subtraction Floating point
// Author: Elena Le
// Project: Capstone 2
//-------------------------------------------------------------------------------------
/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off MULTITOP */
/* verilator lint_off WIDTH *//* verilator lint_off LATCH */
module fadd_sub(
  input logic        clk_i,
  input logic [31:0] operand_a,
  input logic [31:0] operand_b,
  output logic[31:0] result_o
);
  logic [7:0]  a_exponent, b_exponent;            //  exponent operand_a, operand_b, result
  logic [7:0]  result_exponent;
  logic [23:0] a_mantissa, b_mantissa;            //  mantissa operand_a, operand_b,  result
  logic [24:0] result_mantissa;
  logic        a_sign, b_sign, result_sign;       //  sign bit operand_a, operand_b, result
  logic [23:0] tmp_mantissa;
  logic [7:0]  in_e, out_e;
  logic [24:0] in_m, out_m;
  logic [7:0]  diff;
//add_normalizer normalizer(
//  .exponent_i(result_exponent),
//  .mantissa_i(result_mantissa),
//  .exponent_o(out_e),
//  .mantissa_o(out_m)
//);
//assign in_e = result_exponent;
//assign in_m = result_mantissa;
always_ff@(posedge(clk_i))
begin
  a_sign <= operand_a[31];
  b_sign <= operand_b[31];
  if(operand_a[30:23]==0)
    begin
      a_exponent <= (operand_a[22:0] != 0)? 8'b00000001 : 8'b00000000;
      a_mantissa <= {1'b0,operand_a[22:0]};
    end
  else
    begin
      a_exponent <= operand_a[30:23];
      a_mantissa <= {1'b1,operand_a[22:0]};
    end
  if(operand_b[30:23]==0)
    begin
      b_exponent <= (operand_b[22:0] != 0)? 8'b00000001 : 8'b00000000;
      b_mantissa <= {1'b0,operand_b[22:0]};
    end
  else
    begin
      b_exponent <= operand_b[30:23];
      b_mantissa <= {1'b1,operand_b[22:0]};
    end
end
always_comb
begin
  //----------------------------------------------------- CASE: A_EXPONENT == B_EXPONENT ----------------------------------------------------------------------
  if(a_exponent == b_exponent)
    begin
      result_exponent = a_exponent;
      if(a_sign == b_sign)                                                    // sign equal -> add
        begin
          result_sign           = a_sign;
          result_mantissa       = a_mantissa + b_mantissa;
//          result_mantissa[24]   = 1'b1;                                          // flag to shift (normalize)
        end
      else                                                                   // sign not equal ->sub
        begin
          if(a_mantissa > b_mantissa)
            begin
              result_sign     = a_sign;
              result_mantissa = a_mantissa - b_mantissa;
            end
          else
            begin
              result_sign     = b_sign;
              result_mantissa = b_mantissa - a_mantissa;
            end
        end
    end
  //----------------------------------------------------- CASE: A_EXPONENT != B_EXPONENT ----------------------------------------------------------------------
  else                                                                              // different in exponent -> normalize to get same exponent
    begin
      if(a_exponent > b_exponent)
        begin
          result_sign     = a_sign;
          result_exponent = a_exponent;
          diff            = a_exponent - b_exponent;
          tmp_mantissa    = b_mantissa >> diff;
          if(a_sign == b_sign)
            result_mantissa = a_mantissa + tmp_mantissa;
          else
            result_mantissa = a_mantissa - tmp_mantissa;
        end
      else
        begin
          result_sign      = b_sign;
          result_exponent  = b_exponent;
          diff             = b_exponent - a_exponent;
          tmp_mantissa     = a_mantissa >> diff;
          if(a_sign == b_sign)
            result_mantissa  = b_mantissa + tmp_mantissa;
          else
            result_mantissa  = b_mantissa - tmp_mantissa;
        end
    end
  if(result_mantissa[24]==1)
    begin
      result_exponent = result_exponent ^ 1;
      result_mantissa = result_mantissa >> 1;
    end
// else if((result_mantissa[23]!=1) && (result_exponent !=0))
//   begin
//     in_e                  = result_exponent;
//     in_m                  = result_mantissa;
//   end
  result_o = {result_sign, result_exponent, result_mantissa[22:0]};
end
endmodule
