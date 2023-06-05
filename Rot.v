module Rot 


(
    input Clk_i,
    input Rst_i,
    input signed [15:0] X_i,
    input signed [15:0] Y_i,
    input  Sign_i,
    output reg signed [15:0] X_o,
    output reg signed [15:0] Y_o,
    input start_flag
    );

    parameter ShiftNum = 1;

//================================================================================
//  REG/WIRE DECLARATIONS
//================================================================================
wire [15:0] XshftR;
wire [15:0] YshftR;

//================================================================================
//  ASSIGNMENTS
//================================================================================
    assign XshftR = X_i >>> ShiftNum;
    assign YshftR = Y_i >>> ShiftNum;


//================================================================================
//  CODING
//================================================================================


    always @(posedge Clk_i) begin 
        if (Rst_i) begin 
            X_o <= 0;
            Y_o <= 0;
        end 
            else if (start_flag) begin 
                if (Sign_i) begin 
                    X_o <= X_i + YshftR;
                    Y_o <= Y_i - XshftR;
                end 
                else begin 
                    X_o <= X_i - YshftR;
                    Y_o <= Y_i + XshftR;
                end
            end
        end



endmodule




