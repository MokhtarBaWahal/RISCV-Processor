`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2023 10:54:25 AM
// Design Name: 
// Module Name: SSD
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
module SSD (
 input clk,
 input [7:0] num,
 output reg [3:0] Anode,
 output reg [6:0] LED_out
 );

 reg [3:0] LED_BCD;
 reg [19:0] refresh_counter = 0; // 20-bit counter
 reg [3:0] Hundreds;
 reg [3:0] Tens;
 reg [3:0] Ones;
 wire [1:0] LED_activating_counter;
 wire sign;
 assign sign = num[7];
 wire  [7:0] complt;
 assign complt  = ~num +1'b1;
 
 reg [7:0] realnum;

 always @(posedge clk)
     begin
     refresh_counter <= refresh_counter + 1;
     end

 assign LED_activating_counter = refresh_counter[19:18];


always @(*)
begin 
if (sign == 1'b1) begin 

realnum =complt ;
end else begin 
realnum =num ;
end
end

integer i;
 always @(*)
     begin
    //initialization
     
     Hundreds = 4'd0;
     Tens = 4'd0;
     Ones = 4'd0;
    for (i = 6; i >= 0 ; i = i-1 )
    begin
       
        if(Hundreds >= 5 )
             Hundreds = Hundreds + 3;
        if (Tens >= 5 )
             Tens = Tens + 3;
         if (Ones >= 5)
             Ones = Ones +3;
        //shift left one
         
         Hundreds = Hundreds << 1;
         Hundreds [0] = Tens [3];
         Tens = Tens << 1;
         Tens [0] = Ones[3];
         Ones = Ones << 1;
         Ones[0] = realnum [i];
     end
     
   
     
     case(LED_activating_counter)
     2'b00: begin
     Anode = 4'b0111;
     LED_BCD = sign ?4'b1111 : 4'b0000 ;
     end
     2'b01: begin
     Anode = 4'b1011;
     LED_BCD = Hundreds ;
     end
     2'b10: begin
     Anode = 4'b1101;
     LED_BCD = Tens ;
     end
     2'b11: begin
     Anode = 4'b1110;
     LED_BCD = Ones ;
     end
     endcase
 end
 always @(*)
     begin
         case(LED_BCD)
             4'b0000: LED_out = 7'b0000001; // "0"
             4'b0001: LED_out = 7'b1001111; // "1"
             4'b0010: LED_out = 7'b0010010; // "2"
             4'b0011: LED_out = 7'b0000110; // "3"
             4'b0100: LED_out = 7'b1001100; // "4"
             4'b0101: LED_out = 7'b0100100; // "5"
             4'b0110: LED_out = 7'b0100000; // "6"
             4'b0111: LED_out = 7'b0001111; // "7"
             4'b1000: LED_out = 7'b0000000; // "8"
             4'b1001: LED_out = 7'b0000100; // "9"
             4'b1111: LED_out = 7'b1111110; // "-"
             default: LED_out = 7'b0000001; // "0"
         endcase
     end
endmodule
