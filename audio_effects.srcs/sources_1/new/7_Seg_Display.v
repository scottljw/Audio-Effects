`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AY1718 Sem 1 EE2020 Project
// Project Name: Audio Effects
// Module Name: AUDIO_FX_TOP
// Team No.: Wednesday Group 06
// Student Names: Gao Qikai, Li Jiawei
// Matric No.: A0177350E, A0177400M
// Description: 7 Segment Display module, used to display numbers
// 
// Work Distribution:
//////////////////////////////////////////////////////////////////////////////////

module Calculate_Display(
    input clk_20k,
    input [1:0] sw,   // Switches for Mode Selection
    input ctrled,     // Switches for Display Control
    input increVal,   // Btn Up
    input decreVal,   // Btn Down
    input left,       // Btn Left
    input right,      // Btn Right
    input start,      // Btn Central
    output [15:0] displayVal
    );
    reg [1:0] mode;  // 00 for stop watch running
                     // 01 for stop watch value recorded
                     // 10 for timer settings
                     // 11 for timer counting
    reg [15:0] note, timer_set, timer_count, watch_run, watch_rec;
    assign displayVal = sw[1] ? sw[0] ? note
                                      : timeline
                              : mode[1] ? mode[0] ? timer_count
                                                  : timer_set
                                        : mode[0] ? watch_rec
                                                  : watch_run;
    
    reg [3:0] min1, min0, sec1, sec0;
    reg [14:0] divider = 0;
    reg counter = 0;
    reg [1:0] position = 0;
    
    always @ (posedge clk_20k) begin
        divider <= (divider == 19999) ? 0 : divider + 1;
        counter <= (divider == 0) ? ~counter : counter;
    end
    always @ (counter) begin
        if (timer_count[3:0] > 4'b0000) begin
            timer_count <= timer_count - 1;
        end
    end
    always @ (posedge start) begin
        timer_count = timer_set;
    end
    always @ (posedge increVal) begin
        case(position)
            2'b11: min1 <= (min1 == 4'b0110) ? 0 : min1 + 1;
            2'b01: sec1 <= (sec1 == 4'b0110) ? 0 : sec1 + 1;
            2'b10: min0 <= (min0 == 4'b1001) ? 0 : min0 + 1;
            2'b00: sec0 <= (sec0 == 4'b1001) ? 0 : sec0 + 1;
        endcase
    end
    always @ (posedge decreVal) begin
        case(position)
            2'b11: min1 <= (min1 == 0) ? 4'b0110 : min1 - 1;
            2'b01: sec1 <= (sec1 == 0) ? 4'b0110 : sec1 - 1;
            2'b10: min0 <= (min0 == 0) ? 4'b1001 : min0 - 1;
            2'b00: sec0 <= (sec0 == 0) ? 4'b1001 : sec0 - 1;
        endcase
    end
    always @ (posedge left) begin
        position = position + 1;
    end
    always @ (posedge right) begin
        position = position - 1;
    end
    assign displayVal = {min1,min0,sec1,sec0};
endmodule

module Seven_Seg_Display(
    input clk_20k,
    input [15:0] num,
    output reg [6:0] cathode,
    output reg [3:0] anode
    );
    reg [5:0] divider = 0;
    reg [1:0] counter = 0;
    reg [4:0] BCD;
    
    always @ (posedge clk_20k) begin
        divider <= divider + 1;
        counter <= (divider == 0) ? (counter + 1) : counter;
    end
    always @ (counter) begin
        case(counter)
            2'b00: begin
                anode <= 4'b0111;
                BCD = num[15:11];
            end
            2'b01: begin
                anode <= 4'b1011; 
                BCD = num[10:8];
            end
            2'b10: begin
                anode <= 4'b1101;
                BCD = num[7:4];
            end
            2'b11: begin
                anode <= 4'b1110; 
                BCD = num[3:0];
            end
        endcase
        case (BCD)
            4'b0000: cathode <= 7'b1000000;
            4'b0001: cathode <= 7'b1111001;
            4'b0010: cathode <= 7'b0100100;
            4'b0011: cathode <= 7'b0110000;
            4'b0100: cathode <= 7'b0011001;          
            4'b0101: cathode <= 7'b0010010;
            4'b0110: cathode <= 7'b0000010;
            4'b0111: cathode <= 7'b1111000;
            4'b1000: cathode <= 7'b0000000;
            4'b1001: cathode <= 7'b0010000;
        endcase
    end
endmodule
