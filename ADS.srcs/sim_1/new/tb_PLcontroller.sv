`timescale 1ns / 1ps

module tb_PLcontroller;

  // Parameters
  parameter CLK_PERIOD = 5; // Clock period in ns
  
  // Signals
  reg clk;
  reg rstn;
 
  reg i_valid;
  wire i_ready;
  
  //reg [5:0] o_valid;
 // reg o_ready;
  wire [8:0] shiftAdr;
  wire mul_ready;
  reg [3:0] flag;
  reg AXI_out;
  // Instantiate PLcontroller module
  PLcontroller2 uut (
    .clk(clk),
    .rstn(rstn),
    
    .i_valid(i_valid),
    .i_ready(i_ready),
    
    //.o_valid(o_valid),
    //.o_ready(o_ready),
    .shiftAdr(shiftAdr),
    .mul_ready(mul_ready),
    .flag(flag),
    .AXI_out(AXI_out)
  );

  // Clock generation
  always #((CLK_PERIOD/2)) clk = ~clk;

  // Initial block
  initial begin
    // Initialize signals
    clk = 0;
    rstn = 1;
   
    i_valid = 0;
    //o_ready = 0;
    flag = 0;

    // Apply reset
    #10 rstn = 1;
    #10 rstn = 0;
    #10 rstn = 1;

    // Test case 1: Write transpose of matrix B to cache buffer
    #20 
    i_valid = 1;
    

    // Test case 2: Wait for the shiftAdr to reach the last address
    
    #1800;
    flag = 4'b1111;
    #200
   // #5000;
    

    // Test case 3: Reset
//    #20 rstn = 0;
//    #10 rstn = 1;

    // Add more test cases as needed

    // End simulation
    #10 $finish;
  end

endmodule
