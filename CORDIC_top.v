module CORDIC_top (
    input Clk_i,
    input Rst_i,
    input signed [15:0] Angle_i,
    input Start_i,

    output reg signed [15:0] Sin_o,
    output reg signed [15:0] Cos_o,
    output reg Done_o







);
//================================================================================
//  REG/WIRE DECLARATIONS
//================================================================================

 wire	[15:0]	precompAngle[15:0];


//================================================================================
//  LOCALPARAMS
//================================================================================

localparam [15:0] Gain = 16'd53955;






//================================================================================
//  ASSIGNMENTS
//================================================================================

assign precompAngle[0] = 16'd51472;
assign precompAngle[1] = 16'd30386;
assign precompAngle[2] = 16'd16055;
assign precompAngle[3] = 16'd8150;
assign precompAngle[4] = 16'd4091;
assign precompAngle[5] = 16'd2047;
assign precompAngle[6] = 16'd1024;
assign precompAngle[7] = 16'd512;
assign precompAngle[8] = 16'd256;
assign precompAngle[9] = 16'd128;
assign precompAngle[10] = 16'd64;
assign precompAngle[11] = 16'd32;
assign precompAngle[12] = 16'd16;
assign precompAngle[13] = 16'd8;
assign precompAngle[14] = 16'd4;
assign precompAngle[15] = 16'd2;


assign Sin_o = (Done_o) ?  y : 16'h0;
assign Cos_o = (Done_o) ?  x : 16'h0;

assign xPipe[0] = (Start_i) ? Gain : xPipe[0];
assign yPipe[0] = (Start_i) ? 16'h0 : yPipe[0];


//================================================================================
//  CODING
//================================================================================

generate 
    for ( j = 0; j < 16; j = j+1) begin : cordic_pipe
        Rot Rot_inst (
            .Clk_i(Clk_i),
            .Rst_i(Rst_i),
            .X_i(),
            .Y_i(),
            .Sign_i(Angle_i[15]),
            .X_o(),
            .Y_o()
        );
    end
endgenerate





always @(posedge Clk_i ) begin 
        scwSignPipe[0] <= scwSign;
        for ( i = 1; i < 16; i = i=i+1) begin 
            scwSignPipe[i] <= scwSignPipe[i-1];
        end
end


always @(posedge Clk_i) begin 
    if (Rst_i) begin 




always @(posedge Clk_i) begin 
    if (Rst_i) begin 
        xPipe[0] <= 16'h0;
        yPipe[0] <= 16'h0;
        end 
        else  (Start_i) begin 
        xPipe[0] <= Gain;
        yPipe[0] <= 16'h0;
        end

    

generate 
    always @(posedge Clk_i) begin 
        if (Rst_i) begin 
            sin_o <= 16'h0;
        end
        else begin 
            if (Angle[15]) begin 
                sin_o <= yPipe[16];
            end
            else begin 
                


endmodule