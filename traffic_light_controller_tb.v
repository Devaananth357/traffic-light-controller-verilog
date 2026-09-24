`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2026 21:41:50
// Design Name: 
// Module Name: traffic_light_controller_tb
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


module traffic_light_controller_tb();
    reg clk;
    reg reset;
    reg pedestrian;
    
    wire [2:0] highway;
    wire [2:0] side_road;
    wire ped_walk;
    
    traffic_light_controller dut(
        .clk(clk),
        .reset(reset),
        .pedestrian(pedestrian),
        .highway(highway),
        .side_road(side_road),
        .ped_walk(ped_walk)
    );
    
    initial
    begin
        clk = 1'b0;
    end 
    
    always #5 clk = ~clk;
    
    initial
    begin
        reset = 1'b1;
        pedestrian = 1'b0;
        
        #12;
        reset = 1'b0;
        
        #70;
        pedestrian = 1'b1;
        
        #30;
        pedestrian = 1'b0;
        
        #250;
        $finish;
    end
    
    initial
    begin
        $timeformat(-9, 0, " ns", 8);

        $display("Time     | Reset | Ped | Highway | Side | Walk | State | Timer");

        $monitor("%t |   %b   |  %b  |   %b   | %b  |  %b   |   %0d   |   %0d",
             $time, reset, pedestrian, highway, side_road,
             ped_walk, dut.state, dut.timer);
    end
endmodule

