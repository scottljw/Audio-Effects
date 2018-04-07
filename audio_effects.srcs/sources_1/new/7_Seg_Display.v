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
    input clk,
    input clk_20k,
    input [2:0] sw,           // Switches for Mode Selection
    input ctrled,             // Switches for Display Control (Timer vs Stop Watch)
    input increVal,           // Btn Up
    input recordDown,         // Btn Down
    input left,               // Btn Left
    input clear,              // Btn Right
    input start,              // Btn Central
    input [6:0] keybroad,     // Instrumental Keyboard Input
    input start_play,         // flag that tells that recorded audio start playing
    input recording,          // flag that tells that audio is being recording
    input new_clk,
    output [15:0] displayVal, // Display value for 7 Segment
    output reg led            // Signal value for LED
    );

    reg mode = 1'b0;      // {ctrled, mode} 00 for stop watch running
                          //                01 for stop watch value recorded
                          //                10 for timer settings
                          //                11 for timer counting
    reg [15:0] timer_set_out, timer_set, timer_count, watch_run, watch_rec, note, timeline;
    assign displayVal = sw[2] ? note                                  // for instrumental feature
                              : sw[1] ? timeline                      // for recorder feature
                                      : ctrled ? mode ? timer_count
                                                      : timer_set_out
                                               : mode ? watch_rec
                                                      : watch_run;

    reg [14:0] divider = 0;
    reg counter = 0;
    reg [1:0] position = 0;
    reg trig = 0;
    reg [2:0] incre = 3'b100;
    reg [1:0] div = 2'b01;



    initial begin
        led = 1'b1;
	    timer_set = {4'b0101, 4'b1001, 4'b0101, 4'b1001};
	    timer_set_out = {4'b0101, 4'b1001, 4'b0101, 4'b1001};
	    timer_count = {16 {1'b1}};
	    watch_rec = {16 {1'b1}};
        watch_run = {16 {1'b0}};
	    note[11:3] = {{8 {1'b1}}, 1'b0};
	    timeline = {16 {1'b1}};
    end
    
    
    
    
    always begin
        note[2:0] = incre;
    end
    
    
    
    
    
    
    // record stuffs
    always @ (posedge new_clk, posedge start_play, posedge recording) begin
        if (recording == 1'b1) begin
            timeline = {16 {1'b1}};
        end
        else begin
            if (start_play == 1'b1) begin
                timeline = {16 {1'b0}};
            end
            else begin
                if (timeline[3:0] == 4'b1001) begin
                    timeline[3:0] <= 4'b0000;
                    if (timeline[7:4] == 4'b0101) begin
                        timeline[7:4] <= 4'b0000;
                        if (timeline[11:8] == 4'b1001) begin
                            timeline[11:8] <= 4'b0000;
                            if (timeline[15:12] == 4'b0101) begin
                                timeline[15:12] <= 4'b0000;
                            end
                            else timeline[15:12] <= timeline[15:12] + 4'b0001;
                        end
                        else timeline[11:8] <= timeline[11:8] + 4'b0001;
                    end
                    else timeline[7:4] <= timeline[7:4] + 4'b0001;
                end
                else timeline[3:0] <= timeline[3:0] + 4'b0001;
            end
        end
    end
    
    
    
    
    
    
    // music keys
    always @ (keybroad) begin
        case(keybroad)
            7'b1000000: note[15:12] = 4'b0001;
            7'b0100000: note[15:12] = 4'b0010;
            7'b0010000: note[15:12] = 4'b0011;
            7'b0001000: note[15:12] = 4'b0100;
            7'b0000100: note[15:12] = 4'b0101;
            7'b0000010: note[15:12] = 4'b0110;
            7'b0000001: note[15:12] = 4'b0111;
            7'b0000000: note[15:12] = 4'b1110;
            default:    note[15:12] = 4'b1000;
        endcase
    end
	
	
	
	
	
	
	// 1s clock and related
    always @ (posedge clk_20k) begin
        divider <= (divider == 9999) ? 0 : divider + 1;
        counter <= (divider == 0) ? ~counter : counter;
    end
    always @ (posedge counter, posedge clear) begin
        // start timer and counting down every sec
        if ({ctrled, mode} == 2'b11) begin
            if (timer_count[3:0] == 4'b0000) begin
                timer_count[3:0] <= 4'b1001;
                if (timer_count[7:4] == 4'b0000) begin
                    timer_count[7:4] <= 4'b0101;
                    if (timer_count[11:8] == 4'b0000) begin
                        timer_count[11:8] <= 4'b1001;
                        if (timer_count[15:12] == 4'b0000) begin
                            timer_count[15:12] <= 4'b0101;
                        end
                        else timer_count[15:12] <= timer_count[15:12] - 4'b0001;
                    end
                    else timer_count[11:8] <= timer_count[11:8] - 4'b0001;
                end
                else timer_count[7:4] <= timer_count[7:4] - 4'b0001;
            end
            else timer_count[3:0] <= timer_count[3:0] - 4'b0001;
        end
        else timer_count = timer_set;
		
        // blink the digit selected on the 7 seg display
	    if(trig == 1'b1) begin
            case (position)
            2'b00: begin
                timer_set_out <= {timer_set[15:4], 4'b1110};
            end
            2'b01: begin
                timer_set_out <= {timer_set[15:8], 4'b1110, timer_set[3:0]};
            end
            2'b10: begin
                timer_set_out <= {timer_set[15:12], 4'b1110, timer_set[7:0]};
            end
            2'b11: begin
                timer_set_out <= {4'b1110, timer_set[11:0]};
            end
            endcase
            trig <= 1'b0;
        end
        else begin
            timer_set_out <= timer_set;         // lighting up
            trig <= 1'b1;
	end
		
		
	// clear the timer when btnR is pressed
        if (clear == 1'b1) begin
            watch_run <= {16 {1'b0}};         // stop watch, clear
	end
	else begin
            if (watch_run[3:0] == 4'b1001) begin
                watch_run[3:0] <= 4'b0000;
                if (watch_run[7:4] == 4'b0101) begin
                    watch_run[7:4] <= 4'b0000;
                    if (watch_run[11:8] == 4'b1001) begin
                        watch_run[11:8] <= 4'b0000;
                        if (watch_run[15:12] == 4'b0101) begin
                            watch_run[15:12] <= 4'b0000;
                        end
                        else watch_run[15:12] <= watch_run[15:12] + 4'b0001;
                    end
                    else watch_run[11:8] <= watch_run[11:8] + 4'b0001;
                end
                else watch_run[7:4] <= watch_run[7:4] + 4'b0001;
            end
            else watch_run[3:0] <= watch_run[3:0] + 4'b0001;
        end
        
    end
	
	
	
	
	
	
	
    always @ (posedge start) begin
        if (sw[2:1] == 2'b00) begin
            led <= ~led;
            mode <= ~mode;                    // toggle mode
        end
        else begin
            if (sw[2] == 1'b1) begin
                incre <= incre + 3'b001;     // notes
            end
        end
    end
    
    always @ (posedge increVal) begin
        case(position)
            2'b11: timer_set[15:12] <= (timer_set[15:12] == 4'b0101) ? 4'b0000 : timer_set[15:12] + 1;
            2'b10: timer_set[11:8] <= (timer_set[11:8] == 4'b1001) ? 4'b0000 : timer_set[11:8] + 1;
            2'b01: timer_set[7:4] <= (timer_set[7:4] == 4'b0101) ? 4'b0000 : timer_set[7:4] + 1;
            2'b00: timer_set[3:0] <= (timer_set[3:0] == 4'b1001) ? 4'b0000 : timer_set[3:0] + 1;
        endcase
    end
    
    always @ (posedge left) begin
	    if (sw[2:1] == 2'b00 && {ctrled, mode} == 2'b10) begin
            position <= position + 1;      // timer, shift left position
        end
        else begin
            if (sw[1] == 1'b1) begin
                div <= div - 2'b01;        // pitch shifting
            end
        end
        
    end
    
    always @ (posedge recordDown) begin
        watch_rec <= watch_run;        // stop watch, capture
    end
endmodule











module Seven_Seg_Display(
    input clk,
    input [15:0] num,
    output reg [6:0] cathode,
    output reg [3:0] anode
    );
    reg [4:0] divider = 0;
    reg [1:0] counter = 0;
    reg [4:0] BCD;
    
    always @ (posedge clk) begin
        divider <= divider + 1;
        counter <= (divider == 0) ? (counter + 1) : counter;
    end
    always @ (counter) begin
        case(counter)
            2'b00: begin
                anode <= 4'b0111;
                BCD = num[15:12];
            end
            2'b01: begin
                anode <= 4'b1011; 
                BCD = num[11:8];
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
	    default: cathode <= 7'b1111111;
        endcase
    end
endmodule
