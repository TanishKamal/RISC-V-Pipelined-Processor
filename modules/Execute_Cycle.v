module Execute_Cycle(clk, rst,
    RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE,
    ALUControlE,
    RD1_E, RD2_E, Imm_Ext_E,
    RD_E, PCE, PCPlus4E,
    PCSrcE, PCTargetE,
    RegWriteM, MemWriteM, ResultSrcM,
    RD_M, PCPlus4M, WriteDataM, ALU_ResultM
    );

input clk, rst;

input RegWriteE;
input ALUSrcE;
input MemWriteE;
input ResultSrcE;
input BranchE;

input [2:0] ALUControlE;

input [31:0] RD1_E;
input [31:0] RD2_E;
input [31:0] Imm_Ext_E;

input [4:0] RD_E;

input [31:0] PCE;
input [31:0] PCPlus4E;

output PCSrcE;
output RegWriteM;
output MemWriteM;
output ResultSrcM;

output [4:0] RD_M;

output [31:0] PCPlus4M;
output [31:0] WriteDataM;
output [31:0] ALU_ResultM;

output [31:0] PCTargetE;



// Internal signals


wire [31:0] Src_A;
wire [31:0] Src_B_interim;
wire [31:0] Src_B;

wire [31:0] ResultE;

wire ZeroE;



// Pipeline registers


reg RegWriteE_r;
reg MemWriteE_r;
reg ResultSrcE_r;

reg [4:0] RD_E_r;

reg [31:0] PCPlus4E_r;
reg [31:0] RD2_E_r;
reg [31:0] ResultE_r;

assign Src_A = RD1_E;
assign Src_B_interim = RD2_E;



// ALU SOURCE MUX
// ALUSrcE = 0 → register value
// ALUSrcE = 1 → immediate

mux alu_src_mux(
    .a(Src_B_interim),
    .b(Imm_Ext_E),
    .s(ALUSrcE),
    .c(Src_B)
);



// ALU

ALU alu(
    .A(Src_A),
    .B(Src_B),
    .Result(ResultE),
    .ALUControl(ALUControlE),
    .OverFlow(),
    .Carry(),
    .Zero(ZeroE),
    .Negative()
);



// BRANCH TARGET


PC_adder branch_adder(
    .a(PCE),
    .b(Imm_Ext_E),
    .c(PCTargetE)
);



// EX/MEM PIPELINE REGISTER


always @(posedge clk or negedge rst) begin

    if(!rst) begin

        RegWriteE_r <= 0;
        MemWriteE_r <= 0;
        ResultSrcE_r <= 0;
        RD_E_r <= 0;
        PCPlus4E_r <= 0;
        RD2_E_r <= 0;
        ResultE_r <= 0;

    end

    else begin

        RegWriteE_r <= RegWriteE;
        MemWriteE_r <= MemWriteE;
        ResultSrcE_r <= ResultSrcE;
        RD_E_r <= RD_E;
        PCPlus4E_r <= PCPlus4E;
        RD2_E_r <= Src_B_interim;
        ResultE_r <= ResultE;

    end

end



// BRANCH DECISION


assign PCSrcE = ZeroE & BranchE;



// EX/MEM OUTPUTS


assign RegWriteM = RegWriteE_r;
assign MemWriteM = MemWriteE_r;
assign ResultSrcM = ResultSrcE_r;
assign RD_M = RD_E_r;
assign PCPlus4M = PCPlus4E_r;
assign WriteDataM = RD2_E_r;
assign ALU_ResultM = ResultE_r;

endmodule
