
// load_extend.v - logic for extending the data and addr for loading word, half and byte


module load_extend (
    input [31:0] y,
    input [ 2:0] sel,
    output reg [31:0] data,
	 input [31:0] wr_addr
);

always @(*) begin
    case (sel)
    3'b000: data = {{24{y[7]}}, y[7:0]};
    3'b001: data = {{16{y[15]}}, y[15:0]};
    3'b010: data = y;
    3'b011: data = {{24{1'b0}}, y[7:0]};
    3'b100: data = {{16{1'b0}}, y[15:0]};
    default: data = y;
    // 3'b000: begin
        
    //     if ((wr_addr % 4) == 0)
    //         data = {{24{y[7]}}, y[7:0]};
    //     else if ((wr_addr % 4) == 1)
    //         data = {{24{y[15]}}, y[15:8]};
    //     else if ((wr_addr % 4) == 2)
    //         data = {{24{y[23]}}, y[23:16]};
    //     else if ((wr_addr % 4) == 3)
    //         data = {{24{y[31]}}, y[31:24]};


    //     // if ((wr_addr % 4) == 0)
    //     //     // data = {24'b0, y[7:0]};
    //     //     data= (y&({24'b0,8'b1}));
    //     // else if ((wr_addr % 4) == 1)
    //     //     // data = {24'b0, y[15:8]};
    //     //     data= ((y&({16'b0,8'b1,8'b0}))>>8);
    //     // else if ((wr_addr % 4) == 2)
    //     //      data= ((y&({8'b0,8'b1,16'b0}))>>16);
    //     // else if ((wr_addr % 4) == 3)
    //     //      data= ((y&({8'b1,24'b0}))>>24);
    // end

    // 3'b001: data = {{16{y[15]}}, y[15:0]};
    // 3'b010: data = y;
    // 3'b011: begin
        
    //     if ((wr_addr % 4) == 0)
    //         // data = {24'b0, y[7:0]};
    //         data= (y&({24'b0,8'b1}));
    //     else if ((wr_addr % 4) == 1)
    //         // data = {24'b0, y[15:8]};
    //         data= ((y&({16'b0,8'b1,8'b0}))>>8);
    //     else if ((wr_addr % 4) == 2)
    //          data= ((y&({8'b0,8'b1,16'b0}))>>16);
    //     else if ((wr_addr % 4) == 3)
    //          data= ((y&({8'b1,24'b0}))>>24);
    // end
    // 3'b100: data = {16'b0, y[15:0]};
    // default: data = y;
    endcase
end

endmodule