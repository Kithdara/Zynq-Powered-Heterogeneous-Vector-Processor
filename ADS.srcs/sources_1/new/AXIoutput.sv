`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2023 12:20:25 AM
// Design Name: 
// Module Name: PLOutputController
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AXIoutput(
  input clk,
  input rstn,
  input logic signed [15:0][31:0] data_in,
  output logic signed [31:0] data_out,
  output reg valid,
  input data_ready,
  input o_ready
  //output reg  state,
  //output reg [7:0] counter 
);

  reg [7:0] counter; 
  reg  state;  
  // State definitions
  parameter IDLE = 1'b0;
  parameter WAITING = 1'b1 ;
  //parameter SEND_DATA = 2'b01;
  int matSize =16; //Max matrix size
  
  initial begin
      state <= IDLE;
      counter <= 0;
      valid <= 0;
      data_out <= 0;
      end
  always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
      state <= IDLE;
      counter <= 0;
      valid <= 0;
      data_out <= 0;
    end else begin
      case(state)
        IDLE: begin
          valid <= 0;
          if (data_ready) begin
            state <= WAITING;
            valid <= 1 ;
            counter <= 1 ;
            data_out <= data_in[counter];
          end
        end
//        WAITING: begin
//                    if(o_ready)begin
//                        state <= SEND_DATA ;
//                    end  
//                end 
        //default: state <= IDLE;
        
      endcase
      
      //if (state==SEND_DATA) begin
            //begin
                       if(o_ready && state==WAITING)begin
                          if (counter < matSize) begin 
                            data_out <= data_in[counter];
                            counter <= counter + 1;
                          end else begin
                            valid <= 0;
                            counter<=0;
                            state <= IDLE;
                          end
                       end
//                       else 
//                            state <= WAITING ;
                   //end
           // end
    end
  end

endmodule

