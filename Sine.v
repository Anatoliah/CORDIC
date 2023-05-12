`define DEGREE_8_8

module Sine (
    input Clk_i,
    input Rst_i,
    input [15:0] Angle_i,
    input Start_i,

    output reg [15:0] Sine_o,
    output reg Done_o,
    output reg [15:0] Cos_o 
);

reg [15:0] x, y, z;
reg [4:0] i;
reg start_flag;
reg [1:0] di;

`ifdef DEGREE_8_8
function [15:0] tanangle;
  input [3:0] i;
  begin
    case (i)
    0: tanangle = 16'h0A3D;  // theta = 45.000000
    1: tanangle = 16'h051E;   // theta = 22.500000
    2: tanangle = 16'h028B;   // theta = 11.250000
    3: tanangle = 16'h0145;   // theta = 5.625000
    4: tanangle = 16'h00A3;    // theta = 2.812500
    5: tanangle = 16'h0051;    // theta = 1.406250
    6: tanangle = 16'h0029;    // theta = 0.703125
    7: tanangle = 16'h0014;    // theta = 0.351562
    8: tanangle = 16'h000A;     // theta = 0.175781
    9: tanangle = 16'h0005;     // theta = 0.087891
    10: tanangle = 16'h0003;    // theta = 0.043945
    11: tanangle = 16'h0001;     // theta = 0.021973
    12: tanangle = 16'h0001;     // theta = 0.010986
    13: tanangle = 16'h0000;     // theta = 0.005493
    14: tanangle =16'h0000 ;     // theta = 0.002747
    15: tanangle = 16'h0000;     // theta = 0.001373
    endcase
  end
endfunction
`endif

always @(posedge Clk_i) begin 
    if (Rst_i) begin 
        x <= 16'h0;
        y <= 16'h0;
        z <= 16'h0;
        // i <= 5'h0;
        di <= 1'b0;  
    end
    else begin 
        if (Start_i) begin 
            x <= 16'h1359; //Масштабный коэффициент
            y <= 16'h0;
            z <= Angle_i;
            // i <= 5'h0;
            Done_o <= 1'b0;
        end
        else begin 
            if (start_flag) begin
                di <= (z[15])? 2'b11 : 2'b00;
                x <= x - (di[0]? (y >>> i ): 16'h0);
                y <= y + (di[1] ? (x >>> i) : 16'h0);
                z <= z - (di[1] ? tanangle(i) : 16'h0);
            end
        end
    end
end

always @(posedge Clk_i) begin 
    if (Rst_i) begin 
        i <= 5'h0;
    end
    else begin 
        if (i < 15 && !Start_i) begin 
            i <= i+1;
        end
    end
end



always @(posedge Clk_i) begin
    if (Rst_i) begin
        start_flag <= 1'b0;
        Done_o <= 1'b0;
        Sine_o <= 1'b0;
        Cos_o  <= 1'b0;
    end
    else begin
        if (i < 15 && !Start_i) begin
            start_flag <= 1'b1;
        end
        else begin
            start_flag <= 1'b0;
        end
        
        if (i >= 15) begin
            Done_o <= 1'b1;
            Sine_o <= y;
            Cos_o <= x;
        end
    end
end




endmodule 
