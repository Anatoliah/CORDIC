`define DEGREE_8_8

module Sine (
    input Clk_i,
    input Rst_i,
    input [15:0] Angle_i,
    input Start_i,

    output reg [15:0] Sine_o,
    output reg Done_o,
    output  reg [15:0] Cos_o 
);

reg [15:0] x, y, z;
reg [4:0] i;
reg start_flag;
wire  [1:0] di;

assign di = (z[15])? 2'b11 : 2'b00;

`ifdef DEGREE_8_8
function [15:0] tanangle;
  input [3:0] i;
  begin
    case (i)
    0:  tanangle = 16'd51472;  // theta = 45.000000
    1:  tanangle = 16'd30386;   // theta = 22.500000
    2:  tanangle = 16'd16055;   // theta = 11.250000
    3:  tanangle = 16'd8150;   // theta = 5.625000
    4:  tanangle = 16'd4091;    // theta = 2.812500
    5:  tanangle = 16'd2047;    // theta = 1.406250
    6:  tanangle = 16'd1024;    // theta = 0.703125
    7:  tanangle = 16'd512;    // theta = 0.351562
    8:  tanangle = 16'd256;     // theta = 0.175781
    9:  tanangle = 16'd128;     // theta = 0.087891
    10: tanangle = 16'd64;    // theta = 0.043945
    11: tanangle = 16'd32;     // theta = 0.021973
    12: tanangle = 16'd16;     // theta = 0.010986
    13: tanangle = 16'd8;     // theta = 0.005493
    14: tanangle =16'd4 ;     // theta = 0.002747
    15: tanangle = 16'd2;     // theta = 0.001373
    endcase
  end
endfunction
`endif

// always @(posedge Clk_i) begin 
//     if (Rst_i) begin 
//         x <= 16'h0;//initialize 
//         y <= 16'h0;
//         z <= 16'h0;
//         di <= 1'b0;  
//     end
//     else begin 
//         if (Start_i) begin 
//             x <= 16'h1359; //Масштабный коэффициент
//             y <= 16'h0;
//             z <= Angle_i;
//             Done_o <= 1'b0;
//         end
//         else begin
//             for i begin 
//                 if (start_flag) begin
//                 di <= (z[15])? 2'b11 : 2'b00;
//                 x <= x - (di[0]? (y >>> i ): );
//                 y <= y + (di[1] ? (x >>> i) : 16'h0);
//                 z <= z - (di[1] ? tanangle(i) : 16'h0);
//                 end
//                 else begin 

            
//             end
//         end
//     end
// end


always @(posedge Clk_i) begin 
    if (Rst_i) begin 
        x <= 16'h0;
        y <= 16'h0;
        z <= 16'h0;
    end
    else begin 
        if (Start_i) begin 
            x <= 16'd53955; //Масштабный коэффициент
            y <= 16'h0;
            z <= Angle_i;
            Done_o <= 1'b0;
        end
        else begin 
            if (start_flag && (di == 2'b11) && (i <= 15) ) begin
                x <= x - (y >> i);
                y <= y + (x >> i);
                z <= z - tanangle(i);
            end
            else if (start_flag && (di == 2'b00)&&(i <= 15)) begin 
                x <= x + (y >> i);
                y <= y - (x >> i);
                z <= z + tanangle(i);
            end 
        end
    end
end



// always @(posedge Clk_i) begin 
//     if (Rst_i) begin 
//         i <= 5'h0;
//     end
//     else begin 
//         if (i < 15 && !Start_i) begin 
//             i <= i+1;
//         end
//     end
// end



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
