// Based on the service manual schematic digitized by David Winter
// http://www.pong-story.com/1tl200blak_sch.pdf

// Diodes with circle are Ge, others are Si diodes.
// Difference between silicon and germanium diodes: Si need about 0.7 V to conduct, Ge about 0.4 V


// CARDS

// There are 12 known cards, that combine with overlays and additional materials to
// create these games:
//  1: Table Tennis (Pong)
//  2: Ski, Simon Says, Fun Zoo, Percepts
//  3: Tennis, Analogic, Baseball, Hockey, Football (Passing and Kicking), Soccer (1)
//  4: Cat and Mouse, Football (Running), Haunged House, Invasion (1)
//  5: Submarine, Invasion (2), Soccer (2), Wipeout
//  6: Roulette, States, Invasion (3)
//  7: Volleyball
//  8: Basketball, Handball
//  9: Shootout, Dogfight, Prehistoric Safari
// 10: Shooting Gallery
// 11: cancelled Basketball
// 12: Interplanetary Voyage

// Card connections
//  1: 2-4; 6-8-      14-16-    20-22   ; 30-34    ;             ;       ;                  ;       ;          ; 31-      39 ; 35-37
//  2: 2-4; 6-8
//  3: 2-4; 6-8-10-             20-22   ; 30-34    ;             ;       ;                  ;       ;          ; 31-      39 ; 35-37
//  4: 2-4; 6-8-            -18         ;          ;             ;       ;                  ;       ;          ;    33   -39     -37
//  5: 2-4; 6-8-10-             20-22   ; 30-34    ;             ;       ;                  ;       ;          ; 31-33-   39 ; 35-37
//  6: 2-4;                             ;          ; 26-28-38    ; 42-44 ; 3-5  -9
//  7: 2-4; 6-8-10-   14-16-    20-22   ; 30-34    ;             ;       ;            13-27 ;       ;    23-25
//  8: 2-4; 6-8-   12-14        20-22   ;    34-36 ;             ;       ;       9-11-13    ; 15-17 ;          ; 31-      39
//  9: 2-4; 6                        -24;                        ;       ;                  ;       ; 21-23
// 10: 2-4; 6-8-10              20-22-24; 30-34    ;       38-40 ;       ;                  ;       ;    23-25 ; 31-      39 ; 35-37
// 11: 2-4; 6-8-   12-14        20-22   ;    34-36 ;             ;       ;       9-11-13    ; 15-17 ;          ; 31-      39 ; 35-37
// 12: 2-4; 6-8-            -18         ;          ; 26-28       ;       ; 3-5-7            ;       ; 21-23    ;    33-   39-     37
// Card 12 seems defective: Pin 7 is NC, should that be 9 ?

// Card connector "pins" odd numbers on front (?) side, even numbers on the reverse side.
// CARD_P1  : NC
// CARD_P3  : 47uF to ground: Only in card 6
// CARD_P5  : (JU12) PLAYER2_GEN_P2_V_POS: Only in card 6
// CARD_P7  : NC
// CARD_P9  : HAND_CONTROL1_P3_RESET_N : Only in card 6,8
// CARD_P11 : (JU2) FF_BALL_P5_RESET : Card 8, 11
// CARD_P13 : (JU5) GATE_MATRIX_P8_BALL_ON_WALL

// CARD_P15 : (JU11) GATE_MATRIX_P2, GATE_MATRIX_P10, HAND_CONTROL2_P2_RESET_N: Card 8
// CARD_P17 : (JU8) FF_BALL_P3_SET: Card 8, 11

// CARD_P19 : PLAYER1_GEN_P8_ENABLE_OUT: Not used ???

// CARD_P21 : PLAYER2_GEN_P8_ENABLE_OUT: Only card 9
// CARD_P23 : NOT_HIT
// CARD_P25 : BALL_GEN_P8_ENABLE_OUT

// CARD_P27 : HIT_IN_P27 : SCRI-GATE -10kR16- 300pC16-GND : Only Card 7

// CARD_P29 : VERT: Not used ???

// CARD_P31 : GATE_MATRIX_P3
// CARD_P33 : HIT_IN_P33   : -4k7R47- CARD_P18, ->sD4-2k2R48- SCRI-GATE
// CARD_P35 : GATE_MATRIX_P7
// CARD_P37 : IS_PLAYER1 : SUMMER_P1_PLAYER1_OUT -gD2<- SUMMER_P2_PLAYER1_IN
// CARD_P39 : IS_PLAYER2 : SUMMER_P3_PLAYER2_OUT -gD4<- SUMMER_P4_PLAYER2_IN

// CARD_P41 : W3 / NC
// CARD_P43 : NC

// CARD_P2  : Supply_9V
// CARD_P4  : Supply_to_5.6V_Regulator
// CARD_P6  : Retulated_5.6V
// CARD_P8  : PLAYER1_ENABLE     : HAND_CONTROL1_P1_ENABLE - PLAYER1_GEN_P6_ENABLE - PLAYER1_R27_WIDTH - PLAYER1_R29_HEIGHT
// CARD_P10 : WALL_HEIGTH_SMALL  : WALL_R21->WALLL_GENERATOR_P4_HEIGHT
// CARD_P12 : WALL_HORIZ_POS_HIGH: WALL_R10->WALL_GEN_P9: Card 8
// CARD_P14 : WALL_ENABLE        : WALL_GENERATOR_P6 - WALL_WIDTH_R18->WALL_GEN_P7
// CARD_P16 : WALL_WIDTH_SMALL   : WALL_R20->WALL_GEN_P7
// CARD_P18 : CARD_P33_ENABLE    : 4k7R47 - CARD_P33: Card 4
// CARD_P20 : BALL_ENABLE        : BALL_GEN_P6_ENABLE - BALL_R5 - , -BALL_R7-, -FF_ENGLISH_ENABLE
// CARD_P22 : MATRIX_ENABLE      : (JU4) GATE_MATRIX_P6_ENABLE
// CARD_P24 : RIFLETRONIX_ENABLE : RIFLETRONIX_P3_ENABLE

// CARD_P26 : SLOW_DOWN          : 100uF to ground: Only card 6
// CARD_P28 : CONTROL2_HORIZ     : HAND_CONTROL2_P11_HORIZ - PLAYER2_GEN_P9_HORIZ__POS : Only Card 6

// CARD_P30 : TO_1_NOT_TO_2      : FF_ENGLISH_P6_Q
// CARD_P32 : BALL_H_SPEED_ADD   : Not used ???
// CARD_P34 : BALL_H_DIRECTION   :
// CARD_P36 :                    : FF_BALL_P6_Q Only Card 8

// CARD_P38 : RESET_N_ANY_PLAYER : HAND_CONTROL1_P4_RESET_N - HAND_CONTROL2_P4_RESET_N
// CARD_P40 : BALL_VERT_POS_FAST : BALL_R8->BALL_GEN_P2: Only card 10

// CARD_P42 : BALL_VERT_POS_ENG  : BALL_R9->BALL_GEN_P2 - HAND_CONTROL1_P7_ENG - HAND_CONTROL2_P7_ENG: Only Card 6
// CARD_P44 : BALL_VERT_POS_MED  : BALL_R14->BALL_GEN_P2: Only Card 3

// Connection 2-4 is always made to disable all logic when no cart is connected
// Connection to 6 enable features (maybe)


// Gate matrix connections

// CARD_P22 -JU4- GATE_MATRIX_P6_ENABLE -r4k7-     CARD_P31 -JU3- GATE_MATRIX_P3
// CARD_P31 -JU3- GATE_MATRIX_P3        ->sd-r10k- CARD_P15 -JU11- GATE_MATRIX_P2 - GATE_MATRIX_P10 - HAND_CONTROL2_P2_RESET_N
// CARD_P31 -JU3- GATE_MATRIX_P3        ->gd-r10k- GATE_MATRIX_P1 -JU1- HAND_CONTROL1_P2_RESET_N - FF_ENGLISH_P3_SET
// CARD_P31 -JU3- GATE_MATRIX_P3        ->gd-      GATE_MATRIX_P4_BALL - BALL_GEN_P5_OUT - SUM_P5_BALL_IN

// CARD_P22 -JU4- GATE_MATRIX_P6_ENABLE -r4k7-     CARD_P35 - GATE_MATRIX_P7
// CARD_P35 - GATE_MATRIX_P7            ->sd-r10k- CARD_P15 -JU11- GATE_MATRIX_P2 - GATE_MATRIX_P10 - HAND_CONTROL2_P2_RESET_N
// CARD_P35 - GATE_MATRIX_P7            ->gd-r10k- GATE_MATRIX_P9 - HAND_CONTROL2_P3_RESET_N - FF_ENGLISH_P5_RESET
// CARD_P35 - GATE_MATRIX_P7            ->gd-      GATE_MATRIX_P4_BALL - BALL_GEN_P5_OUT - SUM_P5_BALL_IN

// CARD_P22 -JU4- GATE_MATRIX_P6_ENABLE -r4k7-    TMP
// TMP                                  ->sd-     GATE_MATRIX_P8_BALL_ON_WALL -JU5- CARD_13
// TMP                                  ->gd-     GATE_MATRIX_P5_WALL - WALL_GEN_P5_OUT - SUM_P6_WALL_IN
// TMP                                  ->gd-     GATE_MATRIX_P4_BALL - BALL_GEN_P5_OUT - SUM_P5_BALL_IN


// Generator connections

//  1 : VERT
//  2 : VERT_POS
//  3 : GND
//  4 : HEIGHT
//  5 : OUT
//  6 : ENABLE
//  7 : WIDTH
//  8 : ??? OUT_HIGH
//  9 : HORIZ_POS
// 10 : HORIZ

// Regulator
// 9 V battery or supply supply->CART2 - CART4-> 5.6V regulator -> CART6

// Hitstatus
// Q2_B_CROWBAR_RESET -sD2<- CONTROL1_P9_RESET -47kR1- CONTROL1_P1_ENABLE
// Q2_B_CROWBAR_RESET -sD3<- CONTROL2_P9_RESET -47kR1- 5V6
// CARD_P23 - Q2_C -39R51- SCRI-ANODE_NOT_HIT, - 1nC11- GND, - RIFLETRONX_P6_RESET -RIFLETRONX_S2_RESET- GND
// SCRI-GATE -10kR46- GND
// SCRI-GATE -10kR16- 300pC16-GND, CARD_P27
// SCRI-GATE -22kR44- RIFLETRONX_P5_OUT, MAX_6V8, 330pC20
// SCRI-GATE -2k2R48-sD4<- CARD_P33 -4k7R47- CARD_P18

// CROWBAR_RESET: 0V OFF, 0.6V On; D2, D3: 1.27V WITH RESET CLOSED

// Hand control connetions
//  9 : RESET -> Q2_B =
//  3 : RESET_N -> CARD, but also pulls down CROWBAR
//  2 : RESET_N -> pulss down CROWBAR
//               P1 (JU1) GATE_MATRIX_P1, FF_ENGLISH_P3_SET /
//               P2       GATE_MATRIX_P9, FF_ENGLISH_P5_RESET ?
//  4 : RESET_N -> CARD (wired or of both controllers)
// Check above, controllers have same behavior for 9, but inberted for 2 and 3?
//  1 : ENABLE_RESET, H-V_CONTROL (CONTROL2: always enabled)
// 11 : HORIZ_CONTROL: L 3.6V, R 1.8V
//  8 : VERT_CONTROL: T 4V, B 2V, (CONTROL2: CARD)
//  5 : ENGL_B
//  6 : ENGL_T
//  7 : ENGL_CONTROL 1.0 ... 4.8 V

module Odyssey #(
	parameter     CLK_SYS_FREQUENCY
) (
	input         clk,              ///< 20 MHz
	input         reset,

	input signed [7:0] Analog1XP1,
	input signed [7:0] Analog1YP1,
	input signed [7:0] Analog2XP1,
	input signed [7:0] Analog2YP1,

	input signed [7:0] Analog1XP2,
	input signed [7:0] Analog1YP2,
	input signed [7:0] Analog2XP2,
	input signed [7:0] Analog2YP2,

	output reg    HSync,
	output reg    VSync,

	output  [7:0] video
);

// NTSC black and white (not sure if color or bw target frequencies were used in the design)
localparam v_frequency = 60.0; // [Hz] (half) frames per second
localparam h_frequency = v_frequency * 262.5; // [Hz] lines per second
localparam hsync_duration = 4.7e-06; // [s]
localparam vsync_duration = 3.0 / h_frequency; // [s]
// front_porch = 1.5e-6
// blank_duration = 10.9e-6

// HORIZ SYNC GENERATOR
// Produces 15734 Hz pulses
// See: https://en.wikipedia.org/wiki/Multivibrator
//
// t_1 = 0.69 * C1 * (R2 + R22//TM2 + R38) = 42 us
// t_2 = 0.69 * C2 * R5 = 141 us
// C1 = 470pF, R2 = 150k, R22 = 3k9, R38 = 0 - 50k
// C2 = 680pF, R5 = 300k

// For now, ignoring the above comments, and just generate pulses from the spec:
localparam int h_count_period = CLK_SYS_FREQUENCY / h_frequency + 0.5; // = 333333
localparam int hsync_start = h_count_period - hsync_duration * CLK_SYS_FREQUENCY + 0.5;

localparam int hc_bitwidth = $clog2(h_count_period);
reg   [hc_bitwidth-1:0] hc; // 0.3 (- 5.6?) V
always @(posedge clk) begin
	if(reset) begin
		hc <= 0;
	end else begin
		hc <= hc + 1'd1;
		if (hc == hsync_start) begin
			HSync <= 1;
		end else if(hc >= h_count_period - 1) begin
			HSync <= 0;
			hc <= 0;
		end
	end
end

// VERT SYNC GENERATOR
// Produces 60 Hz pulses
// t_1 = 0.69 * C1 * (R2 + R23//TM1 + R39) = 17 ms
// t_2 = 0.69 * C2 * R5 = 21 ms
// C1 = 100nF, R2 = 180k, R23 = 27k, R39 = 0 - 100k
// C2 = 100nF, R5 = 300k
// to get 30Hz -> 33ms period we need R2 + R23//TM1 + R39 = 174k
// seems not possible, probably factor 0.69 is wrong

// For now, ignoring the above comments, and just generate pulses from the spec:
localparam int v_count_period = CLK_SYS_FREQUENCY / v_frequency + 0.5; // = 1269; 333333 / 1269 = 262.67, so not exactly 262.5
localparam int vsync_start = v_count_period - vsync_duration * CLK_SYS_FREQUENCY + 0.5;

localparam int vc_bitwidth = $clog2(v_count_period);
reg   [vc_bitwidth-1:0] vc; // 0.1 (- 5.6?) V
always @(posedge clk) begin
	if (reset) begin
		vc <= 0;
	end else begin
		vc <= vc + 1'd1;
		if (vc == vsync_start) begin
			VSync <= 1;
		end else if (vc >= v_count_period - 1) begin
			VSync <= 0;
			vc <= 0;
		end
	end
end


localparam int player_width = 0.0473 * h_count_period;
localparam int player_height = 0.0763 * v_count_period;

localparam int ball_h_pos = 0.0552 * h_count_period;
localparam int wall_ball_width = player_width / 2;
localparam int ball_v_pos = 0.382 * v_count_period;
localparam int ball_height = player_height/2; // 0.7V

wire ball_out;
Generator #(
	.h_bitwidth(hc_bitwidth),
	.v_bitwidth(vc_bitwidth)
) BALL (
	.clk(clk),
	.reset(reset),

	.P6_ENABLE(1),
	.P8_ENABLE_OUT(1),

	.P10_HORIZ(hc),
	.P9_HORIZ_POS(ball_h_pos), // 1.5 - 4.5V
	.P7_WIDTH(wall_ball_width),

	.P1_VERT(vc),
	.P2_VERT_POS(ball_v_pos),
	.P4_HEIGHT(ball_height),

	.P5_OUT(ball_out)
);

localparam int wall_h_pos = ((1 - 0.165) * h_count_period - wall_ball_width)/2;
localparam int wall_height = v_count_period;

wire wall_out;
Generator #(
	.h_bitwidth(hc_bitwidth),
	.v_bitwidth(vc_bitwidth)
) WALL (
	.clk(clk),
	.reset(reset),

	.P6_ENABLE(1),
	.P8_ENABLE_OUT(1),

	.P10_HORIZ(hc),
	.P9_HORIZ_POS(wall_h_pos), // 2.8V
	.P7_WIDTH(wall_ball_width),

	.P1_VERT(vc),
	.P2_VERT_POS(0), // 2.7V ?  130 kOhm GND
	.P4_HEIGHT(wall_height), // -0.9V ?  120 kOhm to CARD_P10

	.P5_OUT(wall_out)
);

wire player_1_out;
Generator #(
	.h_bitwidth(hc_bitwidth),
	.v_bitwidth(vc_bitwidth)
) PLAYER_1 (
	.clk(clk),
	.reset(reset),

	.P6_ENABLE(1),
	.P8_ENABLE_OUT(1),

	.P10_HORIZ(hc),  // 0.3V
	.P9_HORIZ_POS((Analog1XP1+128) * (h_count_period/256)), // 1.8 - 3.6V
	.P7_WIDTH(player_width),

	.P1_VERT(vc),  // 0.1V
	.P2_VERT_POS((Analog1YP1+128) * (v_count_period/256)), // 3.2V (2V - 4V)
	.P4_HEIGHT(player_height),

	.P5_OUT(player_1_out)
);

wire player_2_out;
Generator #(
	.h_bitwidth(hc_bitwidth),
	.v_bitwidth(vc_bitwidth)
) PLAYER_2 (
	.clk(clk),
	.reset(reset),

	.P6_ENABLE(1),
	.P8_ENABLE_OUT(1),

	.P10_HORIZ(hc),
	.P9_HORIZ_POS((Analog1XP2+128) * (h_count_period/256)), // 3.6 V  (1.8 - 3.6V)
	.P7_WIDTH(player_width),

	.P1_VERT(vc),
	.P2_VERT_POS((Analog1YP2+128) * (v_count_period/256)),
	.P4_HEIGHT(player_height),

	.P5_OUT(player_2_out)
);

assign video =
	(ball_out || wall_out || player_1_out || player_2_out) ? 8'd200 :
	8'd10;

endmodule
