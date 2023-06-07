`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:32:49 05/13/2020 
// Design Name: 
// Module Name:    cordic_rotation 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CORDICROT
#(	parameter   ODAT_W	= 16,
	parameter   SHIFT		= 1)
(
	input	Clk_i,
	input	Rst_i,

	input	signed  [ODAT_W-1:0]	X_i,
	input	signed  [ODAT_W-1:0]	Y_i,
	input	Val_i,
	input	Sign_i,
	output	reg	signed	[ODAT_W-1:0]	X_o,
	output	reg	signed	[ODAT_W-1:0]	Y_o,
	output	reg	Val_o
);
//================================================================================
//  REG/WIRE DECLARATIONS
//================================================================================
    wire    [ODAT_W-1:0]    shiftedInX;
    wire    [ODAT_W-1:0]    shiftedInY;
//================================================================================
//  ASSIGNMENTS
//================================================================================
    assign  shiftedInX    =   X_i >>> SHIFT;
    assign  shiftedInY    =   Y_i >>> SHIFT;
//================================================================================
//  CODING
//================================================================================
always @(posedge Clk_i) begin
    if (Rst_i) begin
        Val_o	<= 1'b0;
    end else if	(Val_i)	begin
        Val_o	<= Val_i;
    end	else	begin
		Val_o	<=	1'b0;
	end
end

always @(posedge Clk_i) begin
    if (Rst_i) begin
        X_o   <= {ODAT_W{1'b0}};
        Y_o   <= {ODAT_W{1'b0}};
    end else if (Val_i) begin
        if (Sign_i) begin
            X_o   <= X_i + shiftedInY;
            Y_o   <= Y_i - shiftedInX; 
        end else begin
            X_o   <= X_i - shiftedInY;
            Y_o   <= Y_i + shiftedInX;
        end
    end
end

endmodule