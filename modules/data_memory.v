module Data_Memory(input clk,rst,WE,
    input [31:0]A,WD,
    output [31:0]RD

    );
    
     reg [31:0] mem [1023:0];

   integer i;

initial begin
    for(i=0;i<1024;i=i+1)
        mem[i] = 32'b0;
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        for(i=0;i<1024;i=i+1)
            mem[i] <= 32'b0;
    end
    else if(WE) begin
        mem[A[31:2]] <= WD;
    end
end

assign RD = (!rst) ? 32'b0 : mem[A[31:2]];
endmodule
