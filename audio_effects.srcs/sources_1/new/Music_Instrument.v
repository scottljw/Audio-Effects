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
    input [7:1] key,
    output [11:0] sound
    );
    reg [7:0] notes [11:0]; // 0 for nothing, 1 to 7 for C to B; based on frequency
    reg [7:1][15:0] counter, period;
    reg [7:1][3:0] count;
    reg [9:0][11:0] sample;

    initial begin
        counter[1] = 0;
        counter[2] = 0;
        counter[3] = 0;
        counter[4] = 0;
        counter[5] = 0;
        counter[6] = 0;
        counter[7] = 0;

    	period[1] = 38222;
        period[2] = 34052;
        period[3] = 30337;
        period[4] = 28634;
        period[5] = 25510;
        period[6] = 22727;
        period[7] = 20247;

        count[1] = 0;
        count[2] = 0;
        count[3] = 0;
        count[4] = 0;
        count[5] = 0;
        count[6] = 0;
        count[7] = 0;

        sample[0] = 127*16; 
        sample[1] = 202*16; 
        sample[2] = 248*16; 
        sample[3] = 248*16; 
        sample[4] = 202*16; 
        sample[5] = 127*16; 
        sample[6] = 52*16;  
        sample[7] = 6*16;   
        sample[8] = 6*16;   
        sample[9] = 52*16;  
    end

    case (key)
        default    : assign sound = notes[0];
        7'b0000001 : assign sound = notes[1];
        7'b0000010 : assign sound = notes[2];
        7'b0000100 : assign sound = notes[3];
        7'b0001000 : assign sound = notes[4];
        7'b0010000 : assign sound = notes[5];
        7'b0100000 : assign sound = notes[6];
        7'b1000000 : assign sound = notes[7];
    endcase

    initial begin
        notes[0] = 0;
    end
    always @ (posedge clk) begin
        counter[1] = (counter[1] == period[1]) ? 0 : (counter[1] + 1);
        if (counter == 0) begin
        	count = (count == 10) ? 0 : count + 1;
        end
        notes[1] = sample[count];
    end
    always @ (posedge clk) begin
        counter[2] = (counter[2] == period[2]) ? 0 : (counter[2] + 1);
        if (counter == 0) begin
        	count = (count == 10) ? 0 : count + 1;
        end
        notes[2] = sample[count];
    end
    always @ (posedge clk) begin
        counter[3] = (counter[3] == period[3]) ? 0 : (counter[3] + 1);
        if (counter == 0) begin
        	count = (count == 10) ? 0 : count + 1;
        end
        notes[3] = sample[count];
    end
    always @ (posedge clk) begin
        counter[4] = (counter[4] == period[4]) ? 0 : (counter[4] + 1);
        if (counter == 0) begin
        	count = (count == 10) ? 0 : count + 1;
        end
        notes[4] = sample[count];
    end
    always @ (posedge clk) begin
        counter[5] = (counter[5] == period[5]) ? 0 : (counter[5] + 1);
        if (counter == 0) begin
        	count = (count == 10) ? 0 : count + 1;
        end
        notes[5] = sample[count];
    end
    always @ (posedge clk) begin
        counter[6] = (counter[6] == period[6]) ? 0 : (counter[6] + 1);
        if (counter == 0) begin
        	count = (count == 10) ? 0 : count + 1;
        end
        notes[6] = sample[count];
    end
    always @ (posedge clk) begin
        counter[7] = (counter[7] == period[7]) ? 0 : (counter[7] + 1);
        if (counter == 0) begin
        	count = (count == 10) ? 0 : count + 1;
        end
        notes[7] = sample[count];
    end
endmodule