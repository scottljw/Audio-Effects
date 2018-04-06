`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AY1718 Sem 1 EE2020 Project
// Project Name: Audio Effects
// Module Name: AUDIO_FX_TOP
// Team No.: Wednesday Group 06
// Student Names: Gao Qikai, Li Jiawei
// Matric No.: A0177350E, A0177400M
// Description: Debouncing module for the push buttons
// 
// Work Distribution:
//////////////////////////////////////////////////////////////////////////////////


module Debounce(input clk, button, output pulse);
    wire [2:0] Q;
    wire f;
    my_CLOCK clock0 (clk, f);
    assign Q[0] = button;
    genvar i;
    generate for(i = 0; i < 2; i = i + 1) begin
        my_DFF DFFinstance (f, Q[i], Q[i + 1]);
    end
    endgenerate
    assign pulse = Q[1] & ~Q[2];
endmodule

module my_DFF(input CLOCK, D, output reg Q);
    initial begin
        Q = 0;
    end
    always @ (posedge CLOCK) begin
        Q <= D;
    end
endmodule

module my_CLOCK(input clk, output reg f);
    reg [10:0] counter = {10 {1'b0}};
    initial begin
        f = 0;
    end
    always @ (posedge clk) begin
        counter <= counter + 1;
        f <= (counter == {10 {1'b0}}) ? ~f : f;
    end
endmodule
