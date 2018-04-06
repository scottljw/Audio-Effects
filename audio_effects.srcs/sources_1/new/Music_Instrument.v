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

module Music_Instrument(
    input CLK,
    input up,          // btnC
    input [6:0] key,
    input ctrl,        // SW[2] which represent the instrumental feature
    output [11:0] out,
    output [6:0] LED
    );
    
    assign LED = ~key;
    
    reg [22:0]counterC=22'b0000000000000000000000;
    reg [22:0]counterD=22'b0000000000000000000000;
    reg [22:0]counterE=22'b0000000000000000000000;
    reg [22:0]counterF=22'b0000000000000000000000;
    reg [22:0]counterG=22'b0000000000000000000000;
    reg [22:0]counterA=22'b0000000000000000000000;
    reg [22:0]counterB=22'b0000000000000000000000;
    
    reg [11:0] soundC = 12'b000000000000;
    reg [11:0] soundD = 12'b000000000000;
    reg [11:0] soundE = 12'b000000000000;
    reg [11:0] soundF = 12'b000000000000;
    reg [11:0] soundG = 12'b000000000000;
    reg [11:0] soundA = 12'b000000000000;
    reg [11:0] soundB = 12'b000000000000;
    
    reg [2:0] factor = 3'b100;
    
    always @ (posedge up) begin
        if (ctrl == 1'b1) begin
            factor = factor + 3'b001;
        end
    end
    
    always @ (posedge CLK) begin
    if(key[6]==1)
        begin             
           counterC <= (counterC == (3057792/(2**factor))) ? 0 : (counterC + 1);
           soundC <= (counterC == 0) ? (soundC == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                    : soundC;
        end
    if(key[5]==1)
        begin                           
            counterD <= (counterD == (2724176/(2**factor))) ? 0 : (counterD + 1);
            soundD <= (counterD == 0) ? (soundD == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                     : soundD;
        end
    if(key[4]==1)
    
        begin                           
                counterE <= (counterE == (2426960/(2**factor))) ? 0 : (counterE + 1);
                soundE <= (counterE == 0) ? (soundE == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                         : soundE;
            end
    if(key[3]==1)
    
         begin                           
                counterF <= (counterF == (2290752/(2**factor))) ? 0 : (counterF + 1);
                soundF <= (counterF == 0) ? (soundF == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                         : soundF;
            end
    if(key[2]==1)
    
          begin                           
                counterG <= (counterG == (2040832/(2**factor))) ? 0 : (counterG + 1);
                soundG <= (counterG == 0) ? (soundG == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                         : soundG;
            end
    if(key[1]==1)
    
           begin                           
                counterA <= (counterA == (1818160/(2**factor))) ? 0 : (counterA + 1);
                soundA <= (counterA == 0) ? (soundA == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                         : soundA;
            end
    if(key[0]==1)
    
            begin                           
                counterB <= (counterB == (1619808/(2**factor))) ? 0 : (counterB + 1);
                soundB <= (counterB == 0) ? (soundB == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                         : soundB;
            end
    end
    assign out = soundC+soundD+soundE+soundF+soundG+soundA+soundB;
endmodule