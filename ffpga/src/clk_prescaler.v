// Custom Module
`timescale 1ns / 1ps
module clk_prescaler(input clk,input reset,output reg tick,output temp);

 reg counter_reg;

  reg [25:0] count;
  
assign temp  = counter_reg;
  
  always @(posedge clk) begin
    if(reset) begin
      count <= 26'h00;
      counter_reg <= 1'b0;
      tick <= 1'b1;
      
    end else if(count <=  49999999) begin
    
      count <= count + 1;
      tick <= 1'b0;
      
   
    end else begin
      count <= 26'h00;
     tick <= 1'b1; // tick pulses high only once every second cause it remains low on 49999999 instances out of total 50000000 instances in one second.
         counter_reg <= ~ counter_reg ;
    end
   
  end

endmodule

