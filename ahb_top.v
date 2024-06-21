//check change from remote
<<<<<<< HEAD
//change repo
//.. on remote
=======
//change on local
//..
>>>>>>> done
module ahb_top(
  input hclk,
  input hresetn,
  input enable_1,
  input [31:0] dina_1,
  input [31:0] dinb_1,
  input [31:0] addr_1,
  input wr_1,
  input [1:0] slave_sel_1,

  input enable_2,
  input [31:0] dina_2,
  input [31:0] dinb_2,
  input [31:0] addr_2,
  input wr_2,
  input [1:0] slave_sel_2,

  output [31:0] dout
);

// master
wire [1:0] sel;
wire [31:0] haddr;
wire hwrite;
wire [3:0] hprot;
wire [2:0] hsize;
wire [2:0] hburst;
wire [1:0] htrans;
wire hmastlock_1;
wire hmastlock_2;
wire hready;
wire [31:0] hwdata;

// slave 1
wire [31:0] hrdata_1;
wire hreadyout_1;
wire hresp_1;

// slave 2
wire [31:0] hrdata_2;
wire hreadyout_2;
wire hresp_2;

// slave 3
wire [31:0] hrdata_3;
wire hreadyout_3;
wire hresp_3;

// slave 4
wire [31:0] hrdata_4;
wire hreadyout_4;
wire hresp_4;

// decoder
wire hsel_1;
wire hsel_2;
wire hsel_3;
wire hsel_4;

// multiplexor
wire [31:0] hrdata;
wire hreadyout;
wire hresp;
//arbiter
wire gnt_1;
wire gnt_2;
wire requir_1;
wire requir_2;
 
 // mux address and data
 wire [31:0] addr_m1;
 wire [31:0] addr_m2;
 wire [31:0] data_m1;
 wire [31:0] data_m2;
 wire [1:0] sel_m;

// Connect master, slaves, decoder, multiplexor, arbiter, mux_add_data

ahb_arbiter arbiter(
    .hclk(hclk),
    .hresetn(hresetn),
    .requir_1(requir_1),
    .requir_2(requir_2),
    .hlock_1(hmastlock_1),
    .hlock_2(hmastlock_2),
    .hresp(hresp),
    
    .gnt_1(gnt_1),
    .gnt_2(gnt_2),
    .hmastlock(hmastlock),
    .slave_sel(sel_m)
);

mux_add_data mux_m12(
    .addr_m1(addr_m1),
    .addr_m2(addr_m2),
    .data_m1(data_m1),
    .data_m2(data_m2),
    .sel(sel_m),

    .haddr(haddr),
    .hdata(hwdata)
    
);

ahb_master master_1(
  .hclk(hclk),
  .hresetn(hresetn),
  .enable(enable_1),
  .dina(dina_1),
  .dinb(dinb_1),
  .addr(addr_1),
  .wr(wr_1),
  .hreadyout(hreadyout),
  .hgrant(gnt_1),
  .hrdata(hrdata),
  .slave_sel(slave_sel_1),
  
  .requir(requir_1),
  .sel(sel),
  .haddr(addr_m1),
  .hsize(hsize),
  .hwrite(hwrite),
  .hburst(hburst),
  .hprot(hprot),
  .htrans(htrans),
  .hmastlock(hmastlock_1),
  .hready(hready),
  .hwdata(data_m1),
  .dout(dout)
);

ahb_master master_2(
  .hclk(hclk),
  .hresetn(hresetn),
  .enable(enable_2),
  .dina(dina_2),
  .dinb(dinb_2),
  .addr(addr_2),
  .wr(wr_2),
  .hreadyout(hreadyout),
  .hgrant(gnt_2),
  .hrdata(hrdata),
  .slave_sel(slave_sel_2),
  
  .requir(requir_2),
  .sel(sel),
  .haddr(addr_m2),
  .hsize(hsize),
  .hwrite(hwrite),
  .hburst(hburst),
  .hprot(hprot),
  .htrans(htrans),
  .hmastlock(hmastlock_2),
  .hready(hready),
  .hwdata(data_m2),
  .dout(dout)
);

// decoder
decoder deco(
  .sel(sel),
  .hsel_1(hsel_1),
  .hsel_2(hsel_2),
  .hsel_3(hsel_3),
  .hsel_4(hsel_4)
);

// slave 1
ahb_slave slave1(
  .hclk(hclk),
  .hresetn(hresetn),
  .hsel(hsel_1),
  .haddr(haddr),
  .hwrite(hwrite),
  .hsize(hsize),
  .hburst(hburst),
  .hprot(hprot),
  .htrans(htrans),
  .hmastlock(hmastlock),
  .hready(hready),
  .hwdata(hwdata),
  .hreadyout(hreadyout_1),
  .hresp(hresp_1),
  .hrdata(hrdata_1)
);

// slave 2
ahb_slave slave2(
  .hclk(hclk),
  .hresetn(hresetn),
  .hsel(hsel_2),
  .haddr(haddr),
  .hwrite(hwrite),
  .hsize(hsize),
  .hburst(hburst),
  .hprot(hprot),
  .htrans(htrans),
  .hmastlock(hmastlock),
  .hready(hready),
  .hwdata(hwdata),
  .hreadyout(hreadyout_2),
  .hresp(hresp_2),
  .hrdata(hrdata_2)
);


// slave 3
ahb_slave slave3(
  .hclk(hclk),
  .hresetn(hresetn),
  .hsel(hsel_3),
  .haddr(haddr),
  .hwrite(hwrite),
  .hsize(hsize),
  .hburst(hburst),
  .hprot(hprot),
  .htrans(htrans),
  .hmastlock(hmastlock),
  .hready(hready),
  .hwdata(hwdata),
  .hreadyout(hreadyout_3),
  .hresp(hresp_3),
  .hrdata(hrdata_3)
);


// slave 4
ahb_slave slave4(
  .hclk(hclk),
  .hresetn(hresetn),
  .hsel(hsel_4),
  .haddr(haddr),
  .hwrite(hwrite),
  .hsize(hsize),
  .hburst(hburst),
  .hprot(hprot),
  .htrans(htrans),
  .hmastlock(hmastlock),
  .hready(hready),
  .hwdata(hwdata),
  .hreadyout(hreadyout_4),
  .hresp(hresp_4),
  .hrdata(hrdata_4)
);

// multiplexor
multiplexor multip(
  .hrdata_1(hrdata_1),
  .hrdata_2(hrdata_2),
  .hrdata_3(hrdata_3),
  .hrdata_4(hrdata_4),
  .hreadyout_1(hreadyout_1),
  .hreadyout_2(hreadyout_2),
  .hreadyout_3(hreadyout_3),
  .hreadyout_4(hreadyout_4),
  .hresp_1(hresp_1),
  .hresp_2(hresp_2),
  .hresp_3(hresp_3),
  .hresp_4(hresp_4),
  .sel(sel),
  .hrdata(hrdata),
  .hreadyout(hreadyout),
  .hresp(hresp)
);



endmodule

