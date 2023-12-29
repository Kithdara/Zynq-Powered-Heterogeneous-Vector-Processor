`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2023 05:42:44 PM
// Design Name: 
// Module Name: Vector_Sum_tb
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


module Vector_Sum_tb;

  logic clk;
  logic reset;
  logic signed [15:0][31:0] vector_in  ;
  logic signed [31:0] vector_sum;
  logic Flag;
    
    
  Vector_Sum dut (
    .clk(clk),
    .reset(reset),
    .vector_in(vector_in),
    .vector_sum(vector_sum),
    .Flag(Flag)
  );

  initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;
  end

  always begin
    #5 clk = ~clk;
  end

  initial begin
    $display("Starting Vector_Sum test bench...");

    // Test case 1: All positive numbers
    vector_in[0] = 1;
    vector_in[1] = 2;
    vector_in[2] = 3;
    vector_in[3] = 4;
    vector_in[4] = 5;
    vector_in[5] = 6;
    vector_in[6] = 7;
    vector_in[7] = 8;
    vector_in[8] = 9;
    vector_in[9] = 10;
    vector_in[10] = 11;
    vector_in[11] = 12;
    vector_in[12] = 13;
    vector_in[13] = 14;
    vector_in[14] = 15;
    vector_in[15] = 16;
    #100;
    $display("vector_sum = %d", vector_sum);

    // Test case 2: All negative numbers
    vector_in[0] = -1;
    vector_in[1] = -2;
    vector_in[2] = -3;
    vector_in[3] = -4;
    vector_in[4] = -5;
    vector_in[5] = -6;
    vector_in[6] = -7;
    vector_in[7] = -8;
    vector_in[8] = -9;
    vector_in[9] = -10;
    vector_in[10] = -11;
    vector_in[11] = -12;
    vector_in[12] = -13;
    vector_in[13] = -14;
    vector_in[14] = -15;
    vector_in[15] = -16;
    #100;
    $display("vector_sum = %d", vector_sum);

    // Test case 3: Mixed positive and negative numbers
    vector_in[0] = 1;
    vector_in[1] = -2;
    vector_in[2] = 3;
    vector_in[3] = -4;
    vector_in[4] = 5;
    vector_in[5] = -6;
    vector_in[6] = 7;
    vector_in[7] = -8;
    vector_in[8] = 9;
    vector_in[9] = -10;
    vector_in[10] = 11;
    vector_in[11] = -12;
    vector_in[12] = 13;
    vector_in[13] = -14;
    vector_in[14] = 15;
    vector_in[15] = -16;
    #100;
    $display("vector_sum = %d", vector_sum);

    $stop;
  end

endmodule
