`timescale 1ns / 1ps
module Sine_tb();


    reg Clk_i;
    reg Rst_i;
    reg   [15:0] Angle_i;
    reg Start_i;
    wire [15:0] Sine_o;
    wire Done_o;

     integer angle;


    integer i ; 

    Sine Sine_inst (
        .Clk_i(Clk_i),
        .Rst_i(Rst_i),
        .Angle_i(Angle_i),
        .Start_i(Start_i),
        .Sine_o(Sine_o),
        .Done_o(Done_o)
    );

    always begin 
        #5 Clk_i = ~Clk_i;
    end



    // CORDICNCO Cordic_instO(
    //     .clk_i(Clk_i),
    //     .rst_i(Rst_i),
    //     .val_i(!Start_i),
    //     .phase_inc_i(Angle_i),
    //     .cos_o(),
    //     .sin_o()


    // );



    

    initial begin 
         Clk_i = 1'b1;
        Rst_i = 1'b1;
        Start_i = 1'b0;
        Angle_i = 16'h0;
        #10 Rst_i = 1'b0;
        Start_i  = 1'b1;
        Angle_i = 16'h51E  ; // 30 градусов
        #20;
            Start_i = 0;



    end

endmodule
    