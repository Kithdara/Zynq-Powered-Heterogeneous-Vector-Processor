module Cache(
  input wire WriteEnable,
  input wire [4:0] Address,
  input wire Clk,
  input logic signed [15:0][31:0] dataIn,
  input logic signed [31:0] PEData_In0, 
  input logic signed [31:0] PEData_In1,
  input logic signed [31:0] PEData_In2,
  input logic signed [31:0] PEData_In3,  
  output logic signed [15:0][31:0] dataOut,
  output logic signed [15:0][31:0] dataOutA,
  output logic signed [15:0][31:0] dataOutB0,
  output logic signed [15:0][31:0] dataOutB1,
  output logic signed [15:0][31:0] dataOutB2,
  output logic signed [15:0][31:0] dataOutB3
);

  reg [17:0][15:0][31:0] CacheData;

  always @(posedge Clk) begin
    if (WriteEnable) 
        begin
        CacheData[Address] <= dataIn;
        end
    else
        begin
        dataOutB0 <= CacheData[Address];
        dataOutB1 <= CacheData[Address+1];
        dataOutB2 <= CacheData[Address+2];
        dataOutB3 <= CacheData[Address+3];
        CacheData[17][Address] <= PEData_In0;
        CacheData[17][Address+1] <= PEData_In1;
        CacheData[17][Address+2] <= PEData_In2;
        CacheData[17][Address+3] <= PEData_In3;
        end
  end

  always @(posedge Clk) begin
    dataOutA <= CacheData[16];
    dataOut <= CacheData[17];
  end
endmodule
