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
    input down,
    input up,
    input [6:0] key,
    output [11:0] out
    );
    
    reg [18:0]counterC=19'b0000000000000000000;
    reg [18:0]counterD=19'b0000000000000000000;
    reg [18:0]counterE=19'b0000000000000000000;
    reg [18:0]counterF=19'b0000000000000000000;
    reg [17:0]counterG=18'b000000000000000000;
    reg [17:0]counterA=18'b000000000000000000;
    reg [17:0]counterB=18'b000000000000000000;
    
    reg [11:0] soundC = 12'b000000000000;
    reg [11:0] soundD = 12'b000000000000;
    reg [11:0] soundE = 12'b000000000000;
    reg [11:0] soundF = 12'b000000000000;
    reg [11:0] soundG = 12'b000000000000;
    reg [11:0] soundA = 12'b000000000000;
    reg [11:0] soundB = 12'b000000000000;
    always @ (posedge CLK) begin
    if(key[6]==1)
        begin             
           counterC <= (counterC == ((down == 0)?(up == 0)?191112 : 95555 : (up==0)? 382224 : 191112)) ? 0 : (counterC + 1);
           soundC <= (counterC == 0) ? (soundC == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                    : soundC;
        end
    if(key[5]==1)
        begin                           
            counterD <= (counterD == ((down == 0)?(up == 0)?170261 : 85130 : (up==0)? 340523 : 170261)) ? 0 : (counterD + 1);
            soundD <= (counterD == 0) ? (soundD == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                     : soundD;
        end
    if(key[4]==1)
    
        begin                           
                counterE <= (counterE == ((down == 0)?(up == 0)?151685 : 75842 : (up==0)? 303371 : 151685)) ? 0 : (counterE + 1);
                soundE <= (counterE == 0) ? (soundE == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                         : soundE;
            end
    if(key[3]==1)
    
         begin                           
                counterF <= (counterF == ((down == 0)?(up == 0)?143172 : 71585 : (up==0)? 286345 : 143172)) ? 0 : (counterF + 1);
                soundF <= (counterF == 0) ? (soundF == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                         : soundF;
            end
    if(key[2]==1)
    
          begin                           
                counterG <= (counterG == ((down == 0)?(up == 0)?127552 : 63775 : (up==0)? 255104 : 127552)) ? 0 : (counterG + 1);
                soundG <= (counterG == 0) ? (soundG == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                         : soundG;
            end
    if(key[1]==1)
    
           begin                           
                counterA <= (counterA == ((down == 0)?(up == 0)?113635 : 56817 : (up==0)? 227272 : 113635)) ? 0 : (counterA + 1);
                soundA <= (counterA == 0) ? (soundA == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                         : soundA;
            end
    if(key[0]==1)
    
            begin                           
                counterB <= (counterB == ((down == 0)?(up == 0)?101238 : 50619 : (up==0)? 202476 : 101238)) ? 0 : (counterB + 1);
                soundB <= (counterB == 0) ? (soundB == 12'b000000000000) ? 12'b001000000000 : 12'b000000000000
                                         : soundB;
            end
    end
    assign out = soundC+soundD+soundE+soundF+soundG+soundA+soundB;
endmodule