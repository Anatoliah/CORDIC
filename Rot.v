module Rot (
    input Clk_i,
    input Rst_i,
    input signed [15:0] X_i,
    input signed [15:0] Y_i,
    input Sign_i,
    output reg signed [15:0] X_o,
    output reg signed [15:0] Y_o
    );

    


    always @(posedge Clk_i) begin 
        if (Rst_i) begin 
            X_o <= 0;
            Y_o <= 0;
        end else begin
            for (i = 0; i < 15; i++) begin 
                if (Sign_i) begin 
                    X_o <= X_i + (Y_i >>> i);
                    Y_o <= Y_i - (X_i >>> i);
                end else begin 
                    X_o <= X_i - (Y_i >>> i);
                    Y_o <= Y_i + (X_i >>> i);
                end
            end
        end
    end



endmodule




