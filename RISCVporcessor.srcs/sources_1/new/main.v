`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2023 10:24:08 AM
// Design Name: 
// Module Name: main
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


module main( input clk, reset, ssdClk, input [1:0] ledSel,input [1:0] ssdSel, output reg [15:0] led, output reg [12:0] ssd

);
    
  
  always @(posedge clk) begin

    if(ledSel == 2'b00) led = i

end  
  
  

 if(ledSel == 4'b0000) led = pc; // a. The PC output (when ssdSel = 0000)
  else if(ledSel == 4'b0001) led = pc_norm;  //The PC+4 adder output (when ssdSel = 0001)
    else if(ledSel == 4'b0010) led = pc_mod;// The branch target adder output (when ssdSel = 0010)
     else if(ledSel == 4'b0011) led = pc; // The PC input (when ssdSel = 0011)
        else if(ledSel == 4'b0100) led = R1; //The data read from the register file based on RS1 (when ssdSel = 0100)
         else if(ledSel == 4'b0101) led = R2; //The data read from the register file based on RS2 (when ssdSel = 0101)
            else if(ledSel == 4'b0110) led = writedata; //The data provided as an input to the register file (when ssdSel = 0110)
                else if(ledSel == 4'b0111) led = immediate; //The immediate generator output (when ssdSel = 0111)
                    else if(ledSel == 4'b1000) led = immediate_shited; //The shift left 1 output (when ssdSel = 1000)
                        else if(ledSel == 4'b1001) led = ; //The output of the ALU 2nd source multiplexer (when ssdSel = 1001)
                            else if(ledSel == 4'b1010) led = ALUout; //The output of the ALU (when ssdSel = 1010)
                                 else if(ledSel == 4'b1011) led = data_out; //The memory output (when ssdSel = 1011)
                                 end
         
    
endmodule
