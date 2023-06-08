module SineWidnow_tb ();

    reg Clk_i;
    reg Rst_i;
    
    reg Start_i; 




    SineWindow SineWindow_inst(
        .Clk_i(Clk_i),
        .Rst_i(Rst_i),
        .Start_i(Start_i)






    );

    always begin 
        #5 Clk_i = ~Clk_i;
    end


    initial begin 
        Clk_i = 1'b1;
        Rst_i = 1'b1;
        Start_i = 1'b0;
        #10 Rst_i = 1'b0;
        Start_i  = 1'b1;
        #20;
        Start_i = 0;

    end



endmodule