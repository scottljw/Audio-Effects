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
    input clock,               // 100MHz
    input clk_20k,
    input [11:0] data_in,
    input restart,             // button that restart recording
    input shift,               // button controls pitch shifting
    output reg [11:0] data_out,
    output reg clear_reading,  // flag of reading status, posedge for starting
    output reg writing         // flag of writing status, 0 for completed
);

    parameter TT = 16384;                 // Total Record Time, 20000 is 1s
    reg [11:0] memory [0:TT-1];           // Bigger buffer
    reg [16:0] counter = {17 {1'b0}};     // writing position
    reg [16:0] reader = {17 {1'b0}};      // reading position
    reg trig = 0;
    
    
    initial begin
        data_out = {12 {1'b0}};
        clear_reading = 1'b0;
        writing = 1'b1;
    end
    
    reg [1:0] freq = 2'b01;
    reg [13:0] accum = 0;
    reg new_clk = 0;
    always @ (posedge clock) begin
        accum <= (accum == 5000/(2**freq)-1) ? 0 : (accum + 1);
        new_clk <= (accum == 0) ? ~new_clk : new_clk;
    end
    
    always @ (posedge shift) begin
        freq <= freq + 2'b01;
    end
    
    always @ (trig, writing) begin
        if (writing == 1'b1) begin
            memory[counter] <= data_in;
            counter <= counter + 1;
        end
        else begin
            counter = {17 {1'b0}};
        end
    end
    
    always @ (posedge clk_20k, posedge restart) begin
        if (restart == 1'b0 && counter != TT) begin
            writing = 1'b1;
            clear_reading = 1'b0;
            trig = ~trig;
        end
        
        else begin
            if (restart == 1'b1) begin
                writing = 1'b1;
                clear_reading = 1'b0;
            end
            if (counter == TT) begin
                writing = 1'b0;
                if (writing == 1'b1) begin
                    clear_reading = 1'b1;
                end
                else begin
                    clear_reading = 1'b0;
                end
            end
        end
    end
    
    always @ (posedge new_clk, posedge clear_reading) begin
        if (clear_reading == 1'b1) begin
            reader = {17 {1'b0}};
        end
        else if (writing == 1'b0) begin
            reader <= reader + 1;
            data_out <= memory[reader];
        end
    end
    
endmodule
