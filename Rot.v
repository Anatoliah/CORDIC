module Rot 
#(parameter ODatWidth = 16,
parameter ShiftNum = 1)

(
    input Clk_i,
    input Rst_i,
    input signed [ODatWidth-1:0] X_i,
    input signed [ODatWidth-1:0] Y_i,
    input  Sign_i,
    input Val_i,
    output reg signed [ODatWidth-1:0] X_o,
    output reg signed [ODatWidth-1:0] Y_o,
    output reg Val_o
    // input start_flag
    );

//================================================================================
//  REG/WIRE DECLARATIONS
//================================================================================
wire [ODatWidth-1:0] XshftR;
wire [ODatWidth-1:0] YshftR;

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
            Val_o	<= 1'b0;
        end else if	(Val_i)	begin
            Val_o	<= Val_i;
        end	else	begin
            Val_o	<=	1'b0;
        end
        end

      

    always @(posedge Clk_i) begin 
        if (Rst_i) begin 
            X_o <= {ODatWidth{1'b0}};
            Y_o <= {ODatWidth{1'b0}};
        end 
            else if (Val_i)   begin 
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




