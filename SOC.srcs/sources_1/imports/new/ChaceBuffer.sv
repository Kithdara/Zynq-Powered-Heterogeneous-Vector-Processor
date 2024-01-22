module CacheBuffer(
  input wire WriteEnable,
  input wire [8:0] Address,
  input wire Clk,
  input logic signed [31:0] dataIn,
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
  int matSize =16;
  always @(posedge Clk) begin
    if (WriteEnable) 
        begin
        CacheData[Address/matSize][Address%matSize] <= dataIn;
        end
    else
        begin
        dataOutB0 <= CacheData[Address/matSize];
        dataOutB1 <= CacheData[Address/matSize+1];
        dataOutB2 <= CacheData[Address/matSize+2];
        dataOutB3 <= CacheData[Address/matSize+3];
        CacheData[17][Address/matSize] <= PEData_In0;
        CacheData[17][(Address/matSize+1)] <= PEData_In1;
        CacheData[17][Address/matSize+2] <= PEData_In2;
        CacheData[17][Address/matSize+3] <= PEData_In3;
        end
      //CacheData[17]<=0;
  end

  always @(posedge Clk) begin
    dataOutA <= CacheData[16];
//    dataOut[0] <= Address/matSize;
//    dataOut[1] <= PEData_In0;
//    dataOut[2] <= PEData_In1;
    dataOut <= 0;//CacheData[17];
    
  end
endmodule
