// Based on the service manual schematic digitized by David Winter
// http://www.pong-story.com/1tl200blak_sch.pdf


module Generator #(
	parameter     h_bitwidth,
	parameter     v_bitwidth
)
(
	input         clk,
	input         reset,

	input         [h_bitwidth-1:0] P10_HORIZ,
	input         [h_bitwidth-1:0] P9_HORIZ_POS,
	input         [h_bitwidth-1:0] P7_WIDTH,
	input         [v_bitwidth-1:0] P1_VERT,
	input         [v_bitwidth-1:0] P2_VERT_POS,
	input         [v_bitwidth-1:0] P4_HEIGHT,
	input         P6_ENABLE,
	input         P8_ENABLE_OUT,

	output reg    P5_OUT
);

always @(posedge clk) begin
	P5_OUT <= P6_ENABLE && P8_ENABLE_OUT &&
		(P9_HORIZ_POS < P10_HORIZ ) && (P10_HORIZ < P9_HORIZ_POS + P7_WIDTH) &&
		(P2_VERT_POS < P1_VERT ) && (P1_VERT < P2_VERT_POS + P4_HEIGHT);
end

endmodule
