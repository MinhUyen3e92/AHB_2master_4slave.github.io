module ahb_arbiter(
    input hclk,
    input hresetn,
    input requir_1,
    input requir_2,
    input hlock_1,
    input hlock_2,
    input hresp,
    
    output reg gnt_1,
    output reg gnt_2,
    output reg hmastlock,
    output reg [1:0] slave_sel
);
always @(posedge hclk, negedge hresetn) begin
  if(!hresetn) begin
    gnt_1 <= 0;
    gnt_2 <= 0;
    hmastlock <= 2'b0;
    slave_sel = 2'b0;
  end
end

always @(posedge hclk, negedge hresetn) begin
  if(requir_1 && !requir_2 && !hresp) begin
    gnt_1 <= 1'b1;
    gnt_2 <= 1'b0;
    slave_sel <= 2'b01;
  end
  else if(!requir_1 && requir_2 && !hresp) begin
    gnt_1 <= 1'b0;
    gnt_2 <= 1'b1;
    slave_sel <= 2'b10;
  end 
  else if(requir_1 && requir_2 && !hresp) begin
    gnt_1 <= 1'b1;
    gnt_2 <= 1'b0;
    slave_sel <= 2'b10;
  end 
  else 
    gnt_1 <= 1'b0;
    gnt_2 <= 1'b0;
    slave_sel <= 2'b00;
  end

endmodule