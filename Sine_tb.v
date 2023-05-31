module Sine_tb();


    reg Clk_i;
    reg Rst_i;
    reg [15:0] Angle_i;
    reg Start_i;
    wire [15:0] Sine_o;
    wire Done_o;

     integer angle;



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



    // integer i,j,k;
    

    // reg signed [15:0] x [90:0];
    // reg signed [15:0] y [90:0];
    // reg signed [15:0] z [90:0];


    // task show_vector_results; 
    // input integer j; 
    // input [15:0] Angle; 
    // begin 
    //     a_i = (j*3.14)/180;
    //     a_o = Angle; 
    //     a_o = a_o/ 


    

    initial begin
         Clk_i = 1'b1;
        Rst_i = 1'b1;
        Start_i = 1'b0;
        Angle_i = 16'h0;
        #10 Rst_i = 1'b0;
        Start_i  = 1'b1;
        Angle_i = 16'd5461 ; // 30 градусов
        #20;

        Start_i = 0;
        // // Wait until Done_o goes high
        while (!Done_o) #10;
        $display("Sine_o for 45 degrees: %h", Sine_o);

        // #250 Start_i = 1;
        // Angle_i = 16'b1000101000111101; // 90 degrees in fixed-point representation
        // #10;

        
    end

endmodule
    