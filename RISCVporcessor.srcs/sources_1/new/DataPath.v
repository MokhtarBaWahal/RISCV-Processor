`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2023 08:58:31 AM
// Design Name: 
// Module Name: DataPath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DataPath( input clk, reset

    );
    
    reg [31:0]pc;
    wire [31:0]instruction;
    wire branch, MR, Mreg, Memwrite, ALUsrc, Regwrite;
    wire [1:0] ALUop;
    reg [31:0] writeData;
    wire [31:0] R1;
    wire [31:0] R2;
    wire [31:0] immediate ;
    wire [3:0] ALUselec;
    wire [31:0] ALUout;
    wire zeroflag;
    wire [31:0] data_out;
    wire [31:0] immediate_shited ;
    wire [31:0] pc_mod;
    wire [31:0] pc_nor;
    //input [5:0] addr, output [31:0] data_out
    InstMem instru_mem (.addr(pc[7:2]), .data_out(instruction));
    
    //branch, MR, Mreg, Memwrite, ALUsrc, Regwrite, output reg [1:0] module ALUControlUnit
    ControlUnit Control (. inst(instruction[6:0]), .branch(branch), .MR(MR), .Mreg(Mreg), .Memwrite(Memwrite), .ALUsrc(ALUsrc ), .Regwrite(Regwrite), .ALUop(ALUop));
    
    //input clk, input [4:0] readAd1, readAd2, writeAd1, input [N-1:0] writeData, input regwrite, input reset, output [N-1:0] R1, R2
   RegFile  ReadREgFILE (.clk(clk), .readAd1( instruction[19:15]),.readAd2( instruction[24:20]), .writeAd1( instruction[11:7]), .writeData(writeData), 
    .regwrite(Regwrite ), .reset(reset), .R1(R1), .R2(R2));
    
    
    immGen immGenerator ( .A(instruction ), .B(immediate ));

    //ALUControlUnit ( input [31:0] inst, output reg [3:0] ALUselec 
    ALUControlUnit  ALUControl (.inst(instruction),.ALUop(ALUop ), .ALUselec( ALUselec));
    //input [N-1:0] A, B, input [3:0] sel, output [N-1:0] ALUout, output zeroflag
    nBitALU ALU( .A(R1), .B(ALUsrc? immediate : R2), .sel(ALUselec), .ALUout (ALUout), .zeroflag (zeroflag)); 
    
    // DataMem (input clk, input MemRead, input MemWrite, input [5:0] addr, input [31:0] data_in, output [31:0] data_out); 
    DataMem memeory ( .clk(clk), .MemRead(MR), .MemWrite (Memwrite ), .addr(ALUout [7:2]), .data_in (R2),.data_out(data_out));  
    
    always @(*)begin 
    if (Mreg ==1'b1 )  writeData = data_out;
    else  writeData = ALUout;
    end

    
//    shiftl shiftgate (.A(immediate), .B(immediate_shited ));
    assign immediate_shited =immediate ;

    FCA adder (.A(pc ), .B(immediate_shited ), .S(pc_mod));
    FCA adder1 (.A(pc ), .B(32'b0100 ), .S(pc_nor));
    
    always @(posedge clk or posedge reset)begin 
    if (reset ) pc =0; 
    else  if ((branch&&zeroflag))  pc = pc_mod;
    else  pc = pc_nor;
    end
    
endmodule
