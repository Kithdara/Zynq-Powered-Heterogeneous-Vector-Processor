`timescale 1ns / 1ps

module tb_TopModule2();

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in nanoseconds

  // Signals
  reg Clk;
  reg rstn;
  reg [31:0] i_data;
  reg i_valid;
  wire i_ready;
  
  reg o_valid;
  reg o_ready;
  reg [31:0] o_data;
  wire signed [15:0][31:0] outBus;
  reg mul_ready;
  reg [3:0] flag;
  reg [3:0] count;
  reg [4:0] flag_count;
  // Instantiate the DUT
  TopModule2 uut (
    .rstn(rstn),
    .i_data(i_data),
    .i_valid(i_valid),
    .i_ready(i_ready),
    .o_valid(o_valid),
    .o_ready(o_ready),
    .o_data(o_data),
    .Clk(Clk),
    .outBus(outBus),
    .mul_ready(mul_ready),
    .flag(flag),
    .flag_count(flag_count)
  );

  // Clock generation
  always begin
    #(CLK_PERIOD/2) Clk = ~Clk;
  end

  always @(posedge Clk) begin
  i_data = count;
  count=count+1;
  end
  // Initial block
  initial begin
    // Initialize signals
    Clk = 0;
    rstn = 1;
    i_data = 1;
    i_valid = 1;
    o_ready = 1;
    count=0;
    #10 rstn = 0;
    #10 rstn = 1;
    
    // Apply reset
    #12600 rstn = 0;
    #50

    // Run the test
   

    // Finish the simulation
    $finish;
  end


endmodule
