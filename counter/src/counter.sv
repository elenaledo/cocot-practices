module counter(
  input        logic clk,
  input        logic rst,
  input        logic mode,
  input  [2:0] logic din,
  output [2:0] logic dout
);

  logic [2:0] next;

  assign dout = next;

always_ff@(posedge(clk)) begin
  if(!rst) begin
    // mode 0 : count up    mode  1: count down
    if(mode)
      next <= din + 3'b001;
    else
      next <= din - 3'b001;
  end
  else
    dout <= 3'b0;
end
endmodule: counter
