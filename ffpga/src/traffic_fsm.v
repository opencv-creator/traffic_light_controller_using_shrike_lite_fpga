`timescale 1ns / 1ps

(* top *) module traffic_fsm(
(* iopad_external_pin, clkbuf_inhibit *) input clk,
(* iopad_external_pin *) input reset,
(* iopad_external_pin *) output osc_en,
(* iopad_external_pin *) output E_red,
(* iopad_external_pin *) output E_yellow,
(* iopad_external_pin *) output E_green,
(* iopad_external_pin *) output S_red,
(* iopad_external_pin *) output S_yellow,
(* iopad_external_pin *) output S_green,
(* iopad_external_pin *) output W_red,
(* iopad_external_pin *) output W_yellow,
(* iopad_external_pin *) output W_green,
(* iopad_external_pin *) output N_red,
(* iopad_external_pin *) output N_yellow,
(* iopad_external_pin *) output N_green,
(* iopad_external_pin *) output E_red_en,
(* iopad_external_pin *) output E_yellow_en,
(* iopad_external_pin *) output E_green_en,
(* iopad_external_pin *) output S_red_en,
(* iopad_external_pin *) output S_yellow_en,
(* iopad_external_pin *) output S_green_en,
(* iopad_external_pin *) output W_red_en,
(* iopad_external_pin *) output W_yellow_en,
(* iopad_external_pin *) output W_green_en,
(* iopad_external_pin *) output N_red_en,
(* iopad_external_pin *) output N_yellow_en,
(* iopad_external_pin *) output N_green_en,
(* iopad_external_pin *) output pulse,
(* iopad_external_pin *) output pulse_en);


assign osc_en = 1'b1;
assign pulse_en = 1'b1;

assign E_red_en = 1'b1;
assign E_yellow_en = 1'b1;
assign E_green_en = 1'b1;
assign S_red_en = 1'b1;
assign S_yellow_en = 1'b1;
assign S_green_en = 1'b1;
assign W_red_en = 1'b1;
assign W_yellow_en = 1'b1;
assign W_green_en = 1'b1;
assign N_red_en = 1'b1;
assign N_yellow_en = 1'b1;
assign N_green_en = 1'b1;


wire tick1;
wire temp;

clk_prescaler p_clk (.clk(clk),.reset(reset),.tick(tick1),.temp(temp));

fsm_trl my_fsm(.clk(clk),.reset(reset),.tick(tick1),.E_red(E_red), .E_yellow(E_yellow), .E_green(E_green),.S_red(S_red), 
.S_yellow(S_yellow), .S_green(S_green),.W_red(W_red), .W_yellow(W_yellow), .W_green(W_green),
   .N_red(N_red), .N_yellow(N_yellow), .N_green(N_green));
   
 assign pulse = temp;  


//fsm my_fsm(.clk(clk),.tick(tick1),.reset(reset),.x(inp), .z(det),.get_state1(state1),.get_state0(state0));

  
endmodule







