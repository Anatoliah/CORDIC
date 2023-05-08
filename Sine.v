module Sine (
    input Clk_i,
    input Rst_i,
    input [15:0] Angle_i,
    input Start_i,

    output reg [15:0] Sine_o,
    output reg Done_o
    );




reg [15:0] x, y, z;
reg [4:0] i;
reg start_flag;
reg [1:0] di;


reg [15:0] arctan_lut [0:15] = {
    16'h0A3D, 16'h051E, 16'h028B, 16'h0145,
    16'h00A3, 16'h0051, 16'h0029, 16'h0014,
    16'h000A, 16'h0005, 16'h0003, 16'h0001,
    16'h0001, 16'h0000, 16'h0000, 16'h0000
};



always @(posedge Clk_i) begin 
    if (Rst_i) begin 
        x <= 16'h0;
        y <= 16'h0;
        z <= 16'h0;
        i <= 5'h0;
        start_flag <= 1'b0;
        Done_o <= 1'b0;
    end
    else begin 
        if (Start_i && !start_flag) begin 
            x <= 16'h1359;
            y <= 16'h0;
            z <= 16'h0;
            i <= 5'h0;
            start_flag <= 1'b1;
            Done_o <= 1'b0;
        end
        else if (start_flag) begin 
            di <= (z[15])? 2'b11 : 2'b00;
            x <= x- (di[0]? (y >>> i ): 16'h0);
            y <= y + (di[1] ? (x >>> i) : 16'h0);
            z <= z - (di[1] ? (arctan_lut[i]) : 16'h0);
            if (i < 15 ) begin 
                i <= i + 1'b1;
            end
            else begin
                start_flag <= 1'b0; 
                Done_o <= 1'b1;
                start_flag <= 1'b0;
                Sine_o <= y;
            end
        end
    end
end











endmodule 



