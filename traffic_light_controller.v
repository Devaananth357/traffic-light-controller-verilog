`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2026 17:48:23
// Design Name: 
// Module Name: traffic_light_controller
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


module traffic_light_controller(
    input clk,
    input reset,
    input pedestrian,
    output reg [2:0] highway,
    output reg [2:0] side_road,
    output reg ped_walk
    );
    
    localparam red = 3'b100;
    localparam yellow = 3'b010;
    localparam green = 3'b001;
    
    localparam hw_green = 3'b000;
    localparam hw_yellow = 3'b001;
    localparam sr_green = 3'b010;
    localparam sr_yellow = 3'b011;
    localparam ped_state = 3'b100;
    reg [3:0] timer;
    
    reg [2:0] state;
    
    always @(posedge clk or posedge reset)
    begin
        if(reset)
        begin
            state <=hw_green;
            timer <= 4'd0;
            highway <= green;
            side_road <= red;
            ped_walk <= 1'b0;
        end
        else
        begin
            case(state)
                hw_green:
                begin
                    highway <= green;
                    side_road <= red;
                    ped_walk <= 1'b0;
                    if(timer == 4'd5)
                    begin
                        state <= hw_yellow;
                        timer <= 4'd0;
                    end
                    else
                    begin
                        timer <= timer + 4'd1;
                    end
                end
                
                hw_yellow:
                begin
                    highway <= yellow;
                    side_road <= red;
                    ped_walk <= 1'b0;
                    if(timer == 4'd2)
                    begin
                        timer <= 4'd0;
                        if(pedestrian == 1'b1)
                        begin
                            state <= ped_state;
                        end
                        else
                        begin
                            state <= sr_green;
                        end
                    end
                    else
                    begin
                        timer <= timer + 4'd1;
                    end
                end
                
                ped_state:
                begin
                    highway <= red;
                    side_road <= red;
                    ped_walk <= 1'b1;
                    if(timer == 4'd3)
                    begin
                        timer <= 4'd0;
                        state <= sr_green;
                    end
                    else
                    begin
                        timer <= timer + 4'd1;
                    end
                end
                
                sr_green:
                begin
                    highway <= red;
                    side_road <= green;
                    ped_walk <= 1'b0;
                    if(timer == 4'd5)
                    begin
                        timer <= 4'd0;
                        state <= sr_yellow;
                    end
                    else
                    begin
                        timer <= timer + 4'd1;
                    end
                end
                
                sr_yellow:
                begin
                    highway <= red;
                    side_road <= yellow;
                    ped_walk <= 1'b0;
                    if(timer == 4'd2)
                    begin
                        timer <= 4'd0;
                        state <= hw_green;
                    end
                    else
                    begin
                        timer <= timer + 4'd1;
                    end
                end
                
                default:
                    begin
                        state <= hw_green;
                        timer <= 4'd0;
                        highway <= red;
                        side_road <= red;
                        ped_walk <= 1'b0;
                    end
                    
            endcase
        end            
    end
endmodule
