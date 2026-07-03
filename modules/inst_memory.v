module inst_memory(input rst, input [31:0]A, output [31:0]RD
 );
 reg [31:0] mem [1023:0];
 integer i;
 assign RD = (rst == 1'b0) ? {32{1'b0}} : mem[A[31:2]];
 
 initial begin
 for(i = 0; i < 1024; i = i + 1)
            mem[i] = 32'h00000013;   // addi x0, x0, 0 (NOP)

 
   $readmemh("memfile.hex",mem);
    $display("mem0 = %h", mem[0]);
    $display("mem1 = %h", mem[1]);
 end
    
endmodule
