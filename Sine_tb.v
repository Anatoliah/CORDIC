module Sine_tb();


    reg Clk_i;
    reg Rst_i;
    reg [15:0] Angle_i;
    reg Start_i;
    wire [15:0] Sine_o;
    wire Done_o;



    Sine Sine_inst (
        .Clk_i(Clk_i),
        .Rst_i(Rst_i),
        .Angle_i(Angle_i),
        .Start_i(Start_i),
        .Sine_o(Sine_o),
        .Done_o(Done_o)
    );

    always begin 
        #10 Clk_i = ~Clk_i;
    end

    initial begin
         Clk_i = 1'b0;
        Rst_i = 1'b1;
        Start_i = 1'b0;
        Angle_i = 16'h0;
        #10 Rst_i = 1'b0;
        Start_i  = 1'b1;
        Angle_i = 16'h2000; // 45 градусов
        #10;

        Start_i = 0;
        // Wait until Done_o goes high
        while (!Done_o) #10;
        $display("Sine_o for 45 degrees: %h", Sine_o);

          $finish;
    end
endmodule
    