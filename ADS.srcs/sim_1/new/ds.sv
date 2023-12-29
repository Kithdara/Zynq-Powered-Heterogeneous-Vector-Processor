module vector_multiplier_tb;
  // Define testbench signals
  logic clk;
  logic cen;
  logic WriteEnable;
  logic Address;
  logic signed [15:0][31:0] k;
  logic signed [15:0][31:0] x;
  logic signed [15:0][31:0] z;
  logic signed [31:0] y;

  // Instantiate the VectorMultiplier module
  vector_multiplier #( ) dut1 (
    .clk(clk),
    .cen(cen),
    .k(k),
    .x(x),
    .y(y)
  );

Chache2 #() dut2(
 .WriteEnable(WriteEnable),
    .Address(Address),
    .Clk(clk),
    .dataIn(k),
    .dataOut(z)
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
    WriteEnable =1;
    Address = 4'b0000;
    // Apply test vectors
    // Example: multiply [1, 2, 3, 4, ...] by [5, 6, 7, 8, ...]
    for (int i = 0; i < 16; i = i + 1) begin
      k[i] = i + 1; // Assign values to k
      x[i] = i - 5; // Assign values to x
    end

    cen = 1; // Enable the multiplier

    // Wait for some time to allow the computation to complete
    #100;

    // Disable the multiplier
    cen = 0;

    // Check the result
    if (y == 0) begin
      $display("Test passed: y = %d", y);
    end else begin
      $display("Test failed: y = %d", y);
    end

    // End the simulation
    $finish;
  end
endmodule
  // Simulation
  


