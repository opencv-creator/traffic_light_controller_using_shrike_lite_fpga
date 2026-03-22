// Custom Module
`timescale 1ns / 1ps
module fsm_trl (
    input clk,
    input reset,
	input tick,

    output reg E_red, E_yellow, E_green,
    output reg S_red, S_yellow, S_green,
    output reg W_red, W_yellow, W_green,
    output reg N_red, N_yellow, N_green
);

parameter [5:0] delay = 6'd20;

reg [5:0] count;
    // timing (clock = 10ns)
    parameter YELLOW_TIME = 2; // 20ns
    parameter GREEN_TIME = 5; // 50ns
    parameter RED_TIME = 1;

    // state encoding (pure Verilog)
    parameter
        E_R = 5'd0, E_Y = 5'd1, E_G = 5'd2,
        S_R = 5'd3, S_Y = 5'd4, S_G = 5'd5, 
        W_R = 5'd6, W_Y = 5'd7, W_G = 5'd8,
        N_R = 5'd9, N_Y = 5'd10, N_G = 5'd11;

    reg [4:0] state, next_state;
    reg [3:0] timer;

    // ---------------------------
    // State register
    // ---------------------------
    always @(posedge clk) begin
        if (reset) begin
            state <= E_R;
            timer <= 0;
            count = 0;
            end
        else if(tick)
        begin
            state <= next_state;
            if(count == delay)
            count = 0;
            else
            count = count+1;
            
            end
            
      
    end

    // ---------------------------
    // Next-state logic (clockwise)
    // ---------------------------
    always @(posedge clk) begin
        next_state = state;
        case (state)
            E_R : next_state = E_Y; 
            E_Y: next_state = E_G; 
            E_G : if (count == delay) next_state = S_R;
         

            S_R:   next_state = S_Y;
            S_Y:  next_state = S_G;
            S_G: if (count == delay)  next_state = W_R;
           

            W_R :    next_state = W_Y;
            W_Y:  next_state = W_G;
            W_G: if (count == delay)  next_state = N_R; 

            N_R :  next_state = N_Y;
            N_Y:  next_state = N_G;
            N_G :if (count == delay) next_state = E_R;
           
            default:
            
            next_state = E_R;
            
        endcase
    end

    // ---------------------------
    // Output logic (ONE direction only)
    // ---------------------------
    always @(posedge clk) begin
    
        if(reset)
        begin
        E_red=1; E_yellow=0; E_green=0;
        S_red=1; S_yellow=0; S_green=0;
        W_red=1; W_yellow=0; W_green=0;
        N_red=1; N_yellow=0; N_green=0;
		
		end
        else
        case (state)
            E_Y: begin E_red=0; E_yellow=1; end
            
            E_G: begin E_yellow=0; E_red=0; E_green=1; end

            S_Y: begin S_red=0; S_yellow=1; end
            
            S_G: begin  S_yellow=0;S_red=0; S_green=1; end

            W_Y : begin W_red=0; W_yellow=1; end
            
            W_G: begin  W_yellow=0;W_red=0; W_green=1; end

            N_Y: begin N_red=0; N_yellow=1; end
            
            N_G: begin  N_yellow=0; N_red=0; N_green=1; end
			default:
			begin
	    E_red=1; E_yellow=0; E_green=0;
        S_red=1; S_yellow=0; S_green=0;
        W_red=1; W_yellow=0; W_green=0;
        N_red=1; N_yellow=0; N_green=0;
			
	 
			
			end
        endcase
    end

endmodule
