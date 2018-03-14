`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AY1718 Sem 1 EE2020 Project
// Project Name: Audio Effects
// Module Name: AUDIO_FX_TOP
// Team No.: Wednesday Group 06
// Student Names: Gao Qikai, Li Jiawei
// Matric No.: A0177350E, A0177400M
// Description: Clock Generator Module, gnerate clock sources of desired frequency
// 
// Work Distribution:
//////////////////////////////////////////////////////////////////////////////////


module Clock_Generator(
    input CLK,           // 100MHz FPGA clock
    output reg clk_20k,  // my 20kHz clock
    output clk_50M       // my 50MHz clock
    );
    reg counter2 = 0;                   // counter for 50M
    reg [12:0]counter1 = {13 {1'b0}};  // counter for 20k
    initial begin
        clk_20k = 0;
    end
    always @ (posedge CLK) begin                                // procedural assignment
        counter2 <= counter2 ^ 1;                               // toggle
        counter1 <= (counter1 == 2499) ? 0 : (counter1 + 1);    // counting 2500 times, then clear
        clk_20k <= (counter1 == 0) ? ~clk_20k : clk_20k;        // toggle when counter is 0
    end                                                         // non-blocking assigning
    assign clk_50M = counter2;                                  // continuously assignment
endmodule
