`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2023 10:08:11 AM
// Design Name: 
// Module Name: test
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


module test(

 );
    
  
reg  clk; 


reg  reset;



    
    localparam clk_period = 20;
initial begin 
reset =1;
#10;
reset =0;



end

initial begin
    clk <= 1'b0;
    forever #(clk_period/2) clk <= ~clk;
end 

DataPath path (.clk(clk), .reset(reset));
initial begin 
     
     #(clk_period);
     

end


endmodule
