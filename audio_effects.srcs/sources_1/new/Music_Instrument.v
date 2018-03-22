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
    
    reg [11:0] sound = 12'b000000000000;
    always @ (posedge CLK) begin
    case (key)
    7'b0000001:
           begin             
           counterC <= (counterC == 382224) ? 0 : (counterC + 1);
           sound <= (counterC == 0) ? (sound == 12'b000000000000) ? 12'b111111111111 : 12'b000000000000
                                    : sound;
        end
    7'b0000010:

        begin                           
            counterD <= (counterD == 340523) ? 0 : (counterD + 1);
            sound <= (counterD == 0) ? (sound == 12'b000000000000) ? 12'b111111111111 : 12'b000000000000
                                     : sound;
        end
    7'b0000100:

        begin                           
                counterE <= (counterE == 303371) ? 0 : (counterE + 1);
                sound <= (counterE == 0) ? (sound == 12'b000000000000) ? 12'b111111111111 : 12'b000000000000
                                         : sound;
            end
    7'b0001000:

         begin                           
                counterF <= (counterF == 286345) ? 0 : (counterF + 1);
                sound <= (counterF == 0) ? (sound == 12'b000000000000) ? 12'b111111111111 : 12'b000000000000
                                         : sound;
            end
    7'b0010000:

          begin                           
                counterG <= (counterG == 255104) ? 0 : (counterG + 1);
                sound <= (counterG == 0) ? (sound == 12'b000000000000) ? 12'b111111111111 : 12'b000000000000
                                         : sound;
            end
    7'b0100000:

           begin                           
                counterA <= (counterA == 227272) ? 0 : (counterA + 1);
                sound <= (counterA == 0) ? (sound == 12'b000000000000) ? 12'b111111111111 : 12'b000000000000
                                         : sound;
            end
    7'b1000000:

            begin                           
                counterB <= (counterB == 202476) ? 0 : (counterB + 1);
                sound <= (counterB == 0) ? (sound == 12'b000000000000) ? 12'b111111111111 : 12'b000000000000
                                         : sound;
            end
    endcase
    end
   assign out = sound;
endmodule