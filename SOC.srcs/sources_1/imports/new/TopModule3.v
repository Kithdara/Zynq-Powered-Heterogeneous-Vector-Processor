`timescale 1ns / 1ps

module TopModule(
    //input logic signed [15:0][31:0] inBus,
    //input logic signed [5:0] command,
    
    input rstn,
    //AXI Slave input
    input [31:0] i_data,
    input i_valid,
    output i_ready,
    
    //AXI Master output
    output o_valid,
    input o_ready,
    output reg [31:0] o_data,
    input Clk
    //output logic signed [15:0][31:0] outBus
    //output mul_ready,
    //output [3:0] flag
    //output reg [4:0] flag_count
);

wire [31:0] PEData_In0;
wire [31:0] PEData_In1;
wire [31:0] PEData_In2;
wire [31:0] PEData_In3;

wire [15:0] dataOutB0 [31:0];
wire [15:0] dataOutB1[31:0];
wire [15:0][31:0] dataOutB2;
wire [15:0][31:0] dataOutB3;

wire [15:0][31:0] dataOutA;
wire [8:0] shiftAdr;
wire [15:0][31:0] outBus;
wire mul_ready;
wire [3:0] flag;
wire AXI_out;

CacheBuffer CacheUnit (
    .WriteEnable(i_ready),
    .Address(shiftAdr),
    .Clk(Clk),
    .dataIn(i_data),
    .PEData_In0(PEData_In0),
    .PEData_In1(PEData_In1),
    .PEData_In2(PEData_In2),
    .PEData_In3(PEData_In3),
    .dataOutA(dataOutA),
    .dataOut(outBus),
    .dataOutB0(dataOutB0),
    .dataOutB1(dataOutB1),
    .dataOutB2(dataOutB2),
    .dataOutB3(dataOutB3)
);

vector_multiplier #( ) PE0 (
    .clk(Clk),
    .cen(1),
    .valid(mul_ready),
    .k(dataOutA),
    .x(dataOutB0),
    .Flag(flag[0]),
    .y(PEData_In0)
);

vector_multiplier #( ) PE1 (
    .clk(Clk),
    .cen(1),
    .valid(mul_ready),
    .k(dataOutA),
    .x(dataOutB1),
    .Flag(flag[1]),
    .y(PEData_In1)
);

vector_multiplier #( ) PE2 (
    .clk(Clk),
    .cen(1),
    .valid(mul_ready),
    .k(dataOutA),
    .x(dataOutB2),
    .Flag(flag[2]),
    .y(PEData_In2)
);

vector_multiplier #( ) PE3 (
    .clk(Clk),
    .cen(1),
    .valid(mul_ready),
    .k(dataOutA),
    .x(dataOutB3),
    .Flag(flag[3]),
    .y(PEData_In3)
);

// Instantiate PLcontroller module
PLcontroller contoller (
    .clk(Clk),
    .rstn(rstn),
    .i_valid(i_valid),
    .i_ready(i_ready),
    .shiftAdr(shiftAdr),
    .mul_ready(mul_ready),
    .flag(flag),
    .AXI_out(AXI_out)
    //.flag_count(flag_count)
);

AXIoutput AXIout (
    .clk(Clk),
    .rstn(rstn),
    .data_in(outBus),
    .data_out(o_data),
    .valid(o_valid),
    .data_ready(1),
    .o_ready(o_ready)
);

endmodule
