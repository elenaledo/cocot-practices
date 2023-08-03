module ctrlunit(
  input  logic       clk,
  input  logic       rst,
  input  logic       req,
  input  logic       avail,
  input  logic       b_zero,
  input  logic       a_lt,
  output logic [1:0] muxa,
  output logic       muxb,
  output logic       a_en,
  output logic       b_en,
  output logic       busy,
  output logic       valid
);

localparam WAIT = 2'd0;
localparam CALC = 2'd1;
localparam DONE = 2'd2;

logic [1:0] state;
logic [1:0] nstate;

rdff fsm(
  .clk(clk),
  .rst(rst),
  .d(nstate),
  .q(state)
);

always_ff@(posedge(clk)) begin
  a_en <= 1'b0;
  b_en <= 1'b0;
  valid<= 1'b0;
  busy <= 1'b0;
  nstate <= state;
  case(state)
    WAIT: begin
      a_en <= 1'b1;
      b_en <= 1'b1;
      muxa<= 2'd0;
      muxb<= 1'b0;
      valid<= 1'b0;
      busy <= 1'b0;
      if(avail)
        nstate <= CALC;
    end
    CALC: begin
      valid <= 1'b0;
      busy  <= 1'b1;
      if(a_lt) begin
        a_en <= 1'b1;
        b_en <= 1'b1;
        muxa<= 2'd1;
        muxb<= 1'b1;
        nstate <= CALC;
      end
      else if(!b_zero) begin
        a_en <= 1'b1;
        muxa <= 2'd2;
        //b_en <= 1'b1;
        //muxb <= 1'b1;
        nstate <= CALC;
      end
      if(b_zero)
        nstate <= DONE;
    end
    DONE: begin
      valid <= 1'b1;
      busy  <= 1'b0;
      if(req)
        nstate <= WAIT;
    end
    default:;
  endcase
end

endmodule: ctrlunit
