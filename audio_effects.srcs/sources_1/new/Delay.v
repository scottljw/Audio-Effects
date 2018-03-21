`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AY1718 Sem 1 EE2020 Project
// Project Name: Audio Effects
// Module Name: AUDIO_FX_TOP
// Team No.: Wednesday Group 06
// Student Names: Gao Qikai, Li Jiawei
// Matric No.: A0177350E, A0177400M
// Description: Top Module, controlling all others
// 
// Work Distribution:
//////////////////////////////////////////////////////////////////////////////////

module Delay(
    input CLOCK,                  // clock source is 20kHz
    input [11:0] data_in,
    output reg [11:0] data_out
    );
    reg [11:0] memory [0:32767];  // 2D array as buffer
    reg [14:0] i = 0;             // writing position
    reg [14:0] j = 12768;         // reading position
    always @ (posedge CLOCK) begin
        memory[i] <= data_in;
        i <= i + 1;
        j <= j + 1;
        data_out <= memory[j];    // delay is 16 - (5 + 1) = 10 periods, 1s
    end
endmodule