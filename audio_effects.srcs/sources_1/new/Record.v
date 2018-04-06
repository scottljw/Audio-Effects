`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AY1718 Sem 1 EE2020 Project
// Project Name: Audio Effects
// Module Name: AUDIO_FX_TOP
// Team No.: Wednesday Group 06
// Student Names: Gao Qikai, Li Jiawei
// Matric No.: A0177350E, A0177400M
// Description: Record and pitch shifting Module, record a 5s audio
// 
// Work Distribution:
//////////////////////////////////////////////////////////////////////////////////


module Record (
    input clk_20k,
    input [11:0] data_in,
    output reg [11:0] data_out
);
    parameter TT = 5; // total time the module is going to record
    initial begin
        data_out = data_in;
    end
endmodule
