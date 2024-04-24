module ahb_top_tb();


reg hclk;
reg hresetn;
reg enable_1;
reg [31:0] dina_1;
reg [31:0] dinb_1;
reg [31:0] addr_1;
reg wr_1;
reg [1:0] slave_sel_1;

reg enable_2;
reg [31:0] dina_2;
reg [31:0] dinb_2;
reg [31:0] addr_2;
reg wr_2;
reg [1:0] slave_sel_2;

wire [31:0] dout;

ahb_top dut(
    .hclk(hclk),
    .hresetn(hresetn),
    .enable_1(enable_1),
    .dina_1(dina_1),
    .dinb_1(dinb_1),
    .addr_1(addr_1),
    .wr_1(wr_1),
    .slave_sel_1(slave_sel_1),

    .enable_2(enable_2);
    .dina_2(dina_2),
    .dinb_2(dinb_2),
    .addr_2(addr_2),
    .wr_2(wr_2),
    .slave_sel_2(slave_sel_2),

    .dout(dout)

);

initial begin
  hclk = 0;
  hresetn = 1;
  enable_1 = 1'b0;
  dina_1 = 32'd0;
  dinb_1 = 32'd0;
  addr_1 = 32'd0;
  wr_1 = 1'b0;
  slave_sel_1 = 2'b00;

  enable_2 = 1'b0;
  dina_2 = 32'd0;
  dinb_@ = 32'd0;
  addr_2 = 32'd0;
  wr_2 = 1'b0;
  slave_sel_2 = 2'b00;
  #10 hresetn = 0;
  #10 hresetn = 1;

   write_m1(2'b00,32'd1,32'd1,32'd2);
   write_m1(2'b00,32'd1,32'd1,32'd2);
   fork begin
    write_m1(2'b00,32'd1,32'd1,32'd2);
    write_m1(2'b00,32'd1,32'd1,32'd2);
   end
   join

end

task write_m1(input [1:0] sel, input [31:0] address, input [31:0] a, input [31:0] b);
begin
  @(posedge hclk)
  slave_sel_1 = sel;
  enable_1 = 1'b1;
  addr_1 = address;
  @(posedge hclk)
  dina_1 = a;
  dinb_1 = b;
  wr_1 = 1'b1;
  @(posedge hclk)
  enable_1 = 1'b0;
end
endtask

task write_m2(input [1:0] sel, input [31:0] address, input [31:0] a, input [31:0] b);
begin
  @(posedge hclk)
  slave_sel_2 = sel;
  enable_2 = 1'b1;
  addr_2 = address;
  @(posedge hclk)
  dina_2 = a;
  dinb_2 = b;
  wr_2 = 1'b1;
  @(posedge hclk)
  enable_2 = 1'b0;
end
endtask


endmodule