module mux_add_data(
    input [31:0] addr_m1,
    input [31:0] addr_m2,
    input [31:0] data_m1,
    input [31:0] data_m2,
    input [1:0] sel,

    output reg [31:0] haddr,
    output reg [31:0] hdata
    
);


always @(*) begin
    case(sel)
    1'b0: begin
        haddr = addr_m1;
        hdata = data_m1;
    end
    1'b1:begin
        haddr = addr_m2;
        hdata = data_m2;
    end
    default: begin
        haddr = 32'b0;
        hdata = 32'b0;
    end

    endcase

end

endmodule