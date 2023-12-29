`timescale 1ns / 1ps

module tb_AXIoutput;
  reg clk;
  reg rstn;
  logic signed [15:0][31:0] data_in;
  logic signed [31:0] data_out;
  reg valid;
  reg data_ready;
  reg o_ready;
  reg  state;
  reg [7:0] counter;

  AXIoutput uut (
    .clk(clk),
    .rstn(rstn),
    .data_in(data_in),
    .data_out(data_out),
    .valid(valid),
    .data_ready(data_ready),
    .o_ready(o_ready)
    //.state(state),
   // .counter(counter)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Initial block
  initial begin
    clk = 0;
    rstn = 0;
    data_ready = 0;
    o_ready = 1;
    data_in = 512'habcd4354355663243545656545675675677567565767455665767556756767588778123467a65645536a35a46a46a65b768b987b6b86b8;

    // Apply reset
    #10 rstn = 1;

    // Test case 1
    data_ready = 1;
    #20;

    // Test case 2
    data_ready = 0;
    #20;
    o_ready = 1;
    #20;

    // Test case 3
    o_ready = 1;
    #20;
    o_ready=1;

    // Test case 4
   // data_ready = 0;
    #150;
    #10 data_ready =1;
    #10 data_ready =0;
    #50
    o_ready = 0;
    #20;
     o_ready = 1;
    #150;
    
    //o_ready = 0;
    #20;

    // Add more test cases as needed

    // Finish simulation
    #10 $stop;
  end
endmodule
