module Writeback_Cycle(input clk, rst, ResultSrcW,
input [31:0] PCPlus4W, ALU_ResultW, ReadDataW,
output [31:0] ResultW

    );
    
    // Declaration of Module
mux result_mux (    
                .a(ALU_ResultW),
                .b(ReadDataW),
                .s(ResultSrcW),
                .c(ResultW)
                );
endmodule
