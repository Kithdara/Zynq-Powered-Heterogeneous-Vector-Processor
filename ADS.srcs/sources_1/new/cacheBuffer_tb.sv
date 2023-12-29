`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2023 09:21:20 PM
// Design Name: 
// Module Name: test2
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


module CacheBuffer_tb;

  logic WriteEnable;
  logic unsigned [8:0] Address;
  logic Clk;
  logic signed [31:0] dataIn;
  logic signed [31:0] PEData_In0;
  logic signed [31:0] PEData_In1;
  logic signed [31:0] PEData_In2;
  logic signed [31:0] PEData_In3;
  
  
  logic signed [15:0][31:0] dataOutA;
  logic signed [15:0][31:0] dataOut;
  logic signed [15:0][31:0] dataOutB0;
  logic signed [15:0][31:0] dataOutB1;
  logic signed [15:0][31:0] dataOutB2;
  logic signed [15:0][31:0] dataOutB3;

  // Instantiate the Cache2 module
  CacheBuffer uut (
    .WriteEnable(WriteEnable),
    .Address(Address),
    .Clk(Clk),
    .dataIn(dataIn),
    .PEData_In0(PEData_In0),
    .PEData_In1(PEData_In1),
    .PEData_In2(PEData_In2),
    .PEData_In3(PEData_In3),
    .dataOutA(dataOutA),
    .dataOut(dataOut),
    .dataOutB0(dataOutB0),
    .dataOutB1(dataOutB1),
    .dataOutB2(dataOutB2),
    .dataOutB3(dataOutB3)
  );

  // Define clock parameters
  
  always begin
    #5 Clk = ~Clk;
  end

  initial begin
    // Initialize signals
    WriteEnable = 0;
    Address = 0;
    Clk = 0;
    dataIn = 32'h11;
    PEData_In0 = 1;
    PEData_In1 = 2;
    PEData_In2 = 3;
    PEData_In3 = 4;
    
    // Testbench stimulus
    $display("Starting Cache2 Testbench");
    
    // Write data to the cache
    WriteEnable = 1;
    Address = 0;
    
    for (int i = 0; i < 15; i = i + 1) begin
      #10;
      Address = Address +1;
      dataIn = dataIn + 32'h11;
    end
    for (int i = 0; i < 15; i = i + 1) begin
      #10;
      Address = Address +8;
      dataIn = dataIn + 32'h11;
    end
   #10;
   Address = 16;
   dataIn =  32'h1234578D;
    #50;
  

    // Read data from the cache
      WriteEnable = 0;
    for(int i =0;i < 16; i= i+4) begin
      Address = i;
        #20;
      end
    


    // Finish the simulation
    $finish;
  end
endmodule

