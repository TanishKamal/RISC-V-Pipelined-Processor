module Pipeline_top(clk, rst

    );
    input clk, rst;

    // Declaration of Interim Wires
     // Fetch/Decode/Execute signals
    wire PCSrcE;
    wire RegWriteW, RegWriteE;
    wire ALUSrcE, MemWriteE, ResultSrcE, BranchE;

    wire [2:0] ALUControlE;
    wire [4:0] RD_E, RS1_E, RS2_E;

    wire [31:0] PCTargetE;
    wire [31:0] InstrD, PCD, PCPlus4D;
    wire [31:0] ResultW;
    wire [31:0] RD1_E, RD2_E, Imm_Ext_E;
    wire [31:0] PCE, PCPlus4E;

    // Execute -> Memory pipeline wires
    wire RegWriteM_in, MemWriteM_in, ResultSrcM_in;
    wire [4:0] RD_M_in;
    wire [31:0] PCPlus4M_in;
    wire [31:0] WriteDataM_in;
    wire [31:0] ALU_ResultM_in;

    // Memory -> Writeback pipeline wires
    wire RegWriteW_in, ResultSrcW;
    wire [4:0] RD_W;
    wire [31:0] PCPlus4W;
    wire [31:0] ALU_ResultW;
    wire [31:0] ReadDataW;

    // Forwarding
    wire [1:0] ForwardAE, ForwardBE;

    // Fetch Stage
   
    fetch_cycle Fetch (
        .clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
    );

    
    // Decode Stage
    
    Decode_Cycle Decode (
        .clk(clk),
        .rst(rst),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .RegWriteW(RegWriteW),
        .RDW(RD_W),
        .ResultW(ResultW),
        .RegWriteE(RegWriteE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .Imm_Ext_E(Imm_Ext_E),
        .RD_E(RD_E),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        .RS1_E(RS1_E),
        .RS2_E(RS2_E)
    );

   
    // Execute Stage
    
    Execute_Cycle Execute (
        .clk(clk),
    .rst(rst),

    .RegWriteE(RegWriteE),
    .ALUSrcE(ALUSrcE),
    .MemWriteE(MemWriteE),
    .ResultSrcE(ResultSrcE),
    .BranchE(BranchE),
    .ALUControlE(ALUControlE),

    .RD1_E(RD1_E),
    .RD2_E(RD2_E),
    .Imm_Ext_E(Imm_Ext_E),

    .RD_E(RD_E),
    .PCE(PCE),
    .PCPlus4E(PCPlus4E),

    .PCSrcE(PCSrcE),
    .PCTargetE(PCTargetE),

   
    .RegWriteM(RegWriteM_in),
    .MemWriteM(MemWriteM_in),
    .ResultSrcM(ResultSrcM_in),
    .RD_M(RD_M_in),
    .PCPlus4M(PCPlus4M_in),
    .WriteDataM(WriteDataM_in),
    .ALU_ResultM(ALU_ResultM_in),

    // Forwarding inputs
    .ResultW(ResultW),
    .ALU_ResultM_in(ALU_ResultM_in),

    .ForwardA_E(ForwardAE),
    .ForwardB_E(ForwardBE)
    );

    
    // Memory Stage
    
    Memory_Cycle Memory (
        .clk(clk),
        .rst(rst),

        .RegWriteM(RegWriteM_in),
        .MemWriteM(MemWriteM_in),
        .ResultSrcM(ResultSrcM_in),
        .RD_M(RD_M_in),
        .PCPlus4M(PCPlus4M_in),
        .WriteDataM(WriteDataM_in),
        .ALU_ResultM(ALU_ResultM_in),

        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .RD_W(RD_W),
        .PCPlus4W(PCPlus4W),
        .ALU_ResultW(ALU_ResultW),
        .ReadDataW(ReadDataW)
    );

    
    // Writeback Stage
    
    Writeback_Cycle WriteBack (
        .clk(clk),
        .rst(rst),
        .ResultSrcW(ResultSrcW),
        .PCPlus4W(PCPlus4W),
        .ALU_ResultW(ALU_ResultW),
        .ReadDataW(ReadDataW),
        .ResultW(ResultW)
    );

    
    // Hazard Unit
    
    hazard_unit Forwarding_block (
        .rst(rst),

        .RegWriteM(RegWriteM_in),
        .RegWriteW(RegWriteW),

        .RD_M(RD_M_in),
        .RD_W(RD_W),

        .Rs1_E(RS1_E),
        .Rs2_E(RS2_E),

        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE)
    );

endmodule
