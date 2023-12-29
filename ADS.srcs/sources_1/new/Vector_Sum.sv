`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2023 03:15:17 PM
// Design Name: 
// Module Name: Stupid_ADD
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

module Vector_Sum(

  input clk,
  input reset,
  input logic signed  [15:0][31:0] vector_in ,
  output logic signed  [31:0] vector_sum,
  output logic  Flag
    );
    
  logic signed [7:0][31:0] vec8_1 = vector_in[7:0];
  logic signed [7:0][31:0] vec8_2 = vector_in[15:8]; 
  
  reg [31:0] sum1,sum2;
  reg [2:0] counter;
  //reg [31:0] vec8_1; 
   
  always @(posedge clk) begin
    if (reset) begin
      sum1 <= 0;
      sum2 <= 0;
      counter <= 0;
    end else begin
      if (counter < 8) begin
        sum1 <= sum1 + vec8_1[counter];
        sum2 <= sum2 + vec8_2[counter];
        counter <= counter + 1;
      end
    end
    
  end


  assign vector_sum = sum1+sum2;
  assign Flag = counter[2];

endmodule