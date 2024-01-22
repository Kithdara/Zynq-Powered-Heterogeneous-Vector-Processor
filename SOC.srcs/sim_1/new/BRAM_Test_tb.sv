`timescale 1ns / 1ps

module BRAM_Test_tb;

  // Define constants
  parameter CLK_PERIOD = 10; // Clock period in time units
  parameter MEM_DEPTH = 256; // Depth of the memory

  // Declare signals
  logic clk, en, we;
  logic [7:0] addr;
  logic i_valid;
  logic [31:0] din;
  logic [511:0] dout;

  // Instantiate the module under test
  BRAM_Test dut (
    .clk(clk),
    .en(en),
    .we(we),
    .addr(addr),
    .i_valid(i_valid),
    .din(din),
    .dout(dout)
  );

  // Clock generation
  always # (CLK_PERIOD / 2) clk = ~clk;

  // Test stimulus
  initial begin
    // Initialize inputs
    clk = 0;
    en = 1;
    we = 0;
    addr = 0;
    i_valid = 1;
    din = 32'hAABBCCDD;

    // Apply inputs and observe outputs
    #20; // Wait a bit before changing inputs

    // Example test scenario - write data to memory location 0
    we = 1; // Enable write
    addr = 16; // Address to write
    din = 32'h4; // Data to write
    #20; // Wait for write operation

    we = 0; // Disable write
    addr = 1; // Read from the same address
    i_valid = 0; // Invalidate input data for read
    #20; // Wait for read operation

    // Add more test scenarios here...

    // Finish simulation after test cases
    $finish;
  end

endmodule
