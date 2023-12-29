`timescale 1ns / 1ps

module tb_TopModule();

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
  
  reg [511:0][31:0] MatAB;
  reg [255:0][31:0] MatAns;
  

  //wire signed [15:0][31:0] outBus;
 // reg mul_ready;
  //reg [3:0] flag;
  int count;
  int count2;
  
  // Instantiate the DUT
  TopModule uut (
    .rstn(rstn),
    .i_data(i_data),
    .i_valid(i_valid),
    .i_ready(i_ready),
    .o_valid(o_valid),
    .o_ready(o_ready),
    .o_data(o_data),
    .Clk(Clk)
    //.outBus(outBus),
    //.mul_ready(mul_ready),
    //.flag(flag)
    
  );

  // Clock generation
  always begin
    #(CLK_PERIOD/2) Clk = ~Clk;
  end
  
  //AXI In
  always @(posedge Clk) begin
      if (i_ready && i_valid) begin
      i_data = MatAB[count];
      count=count+1;
      end
  end
  
    //AXI out
  always @(posedge Clk) begin
      if (o_ready && o_valid) begin
      MatAns[count2] = o_data;
      count2=count2+1;
      end
  end
  // Initial block
  initial begin
    // Initialize signals
    for (int i = 0; i < 256; i = i + 1) begin
        MatAB[i] = i;
        MatAB[i+256] = i;
    end
    Clk = 0;
   rstn = 1;
    i_data = 1;
    i_valid = 1;
    o_ready = 1;
    count=0;
    count2=0;
    //#10 rstn = 0;
   // #10 rstn = 1;
    
    // Apply reset
    //#2735 
  // i_valid = 0;
    #4000
    i_valid = 1;
    #8600
    #50


           $display("Matrix Display:");
      for (int row = 0; row < 16; row = row + 1) begin
        for (int col = 0; col < 16; col = col + 1) begin
          $write("%8d ", MatAns[row*16 + col]);
        end
        $display(""); // Newline after each row
      end
      $display(""); // Extra newline for better formatting

    // Finish the simulation
    $finish;
    

    end
  


endmodule
