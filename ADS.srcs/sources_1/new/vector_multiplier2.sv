module vector_multiplier_tb;
  // Define testbench signals
  logic clk;
  logic cen;
  logic valid;
  logic Flag;
  logic signed [15:0][31:0] k;
  logic signed [15:0][31:0] x;
  logic signed [31:0] y;
  //logic [3:0] counter;
  logic signed [15:0][31:0] mul;

  // Instantiate the VectorMultiplier module
  vector_multiplier #( ) dut (
    .clk(clk),
    .cen(cen),
    .valid(valid),
    .k(k),
    .x(x),
    .Flag(Flag),
    .mul_vector(mul),
    .y(y)
  );

  // Clock generation
  always begin
    #5 clk = ~clk; // Toggle the clock every 5 time units
  end

  // Stimulus generation
  initial begin
    // Initialize signals
    clk = 0;
    cen = 0;
    k = 0;
    x = 0;
    
    // Apply test vectors
    // First Test case
    
    for (int i = 0; i < 16; i = i + 1) begin
      k[i] = 1; // Assign values to k
      x[i] = 1; // Assign values to x
    end
    
   valid = 1;
    cen = 1; // Enable the multiplier
    #10;
    valid = 0;
    #190;
    cen = 0;
    
    // Check the result
    if (y == 16) begin
      $display("1 st Test passed: y = %d", y);
    end else begin
      $display("1 st Test failed: y = %d", y);
    end

     // Second Test case
    
    for (int i = 0; i < 16; i = i + 1) begin
      k[i] = 1; // Assign values to k
      x[i] = -1; // Assign values to x
    end

   valid = 1;
    cen = 1; // Enable the multiplier
    #10;
    valid = 0;
    #190;
    cen = 0;
    // Check the result
    if (y == -16) begin
      $display("2 nd Test passed: y = %d", y);
    end else begin
      $display("2 nd Test failed: y = %d", y);
    end
    
    // Third test
    
    for (int i = 0; i < 16; i = i + 1) begin
      k[i] = -2; // Assign values to k
      x[i] = -1; // Assign values to x
    end

    valid = 1;
    cen = 1; // Enable the multiplier
    #10;
    valid = 0;
    #190;
    cen = 0;

    // Check the result
    if (y == 16) begin
      $display("3 rd Test passed: y = %d", y);
    end else begin
      $display("3 rd Test failed: y = %d", y);
    end

    // End the simulation
    $finish;
  end
endmodule
  // Simulation