module Register_File( input clk,rst,WE3,
    input [4:0]A1,A2,A3,
    input [31:0]WD3,
    output [31:0]RD1,RD2 );
    
    reg [31:0] Register [31:0];
    integer i;

    // Initialize all registers to zero
    initial begin
        for(i = 0; i < 32; i = i + 1)
            Register[i] = 32'b0;
    end

   always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            for(i = 0; i < 32; i = i + 1)
                Register[i] <= 32'b0;
        end
        else begin
            if(WE3 && (A3 != 5'b00000))
                Register[A3] <= WD3;
        end
    end

    // Read operation
    assign RD1 = (rst == 1'b0) ? 32'b0 :
                 (A1 == 5'b00000) ? 32'b0 : Register[A1];

    assign RD2 = (rst == 1'b0) ? 32'b0 :
                 (A2 == 5'b00000) ? 32'b0 : Register[A2];
    

endmodule
