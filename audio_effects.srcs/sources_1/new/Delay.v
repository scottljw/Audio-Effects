`timescale 1us / 1ns
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
    input CLOCK,
    input [7:0] data_in,
    output [7:0] data_out
    );
    reg [7:0] memory [0:15];   // 2D array as buffer
    reg [3:0] i = 0;           // writing position
    reg [3:0] j = 5;           // reading position
    reg [10:0] counter = 0;    // clock divider
    always @ (posedge CLOCK) begin                         // clock source is 20kHz
        counter <= (counter == 1999) ? 0 : (counter + 1);  // divide the frequency by 2k
        if (counter == 0) begin                            // get a frequency of 10Hz
            memory[i] <= data_in;
            i <= i + 1;
            j <= j + 1;
        end
    end
    assign data_out = memory[j];  // delay is 16 - (5 + 1) = 10 periods, 1s
endmodule