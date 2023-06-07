

module Sine  (
    input Clk_i,
    input Rst_i,
    input  [15:0] Angle_i,
    input Start_i,

    output reg signed [15:0] Sine_o,
    output reg Done_o,
    output  reg  signed  [15:0] Cos_o ,
    output start_flag_o 
);

//================================================================================
//  LOCALPARAMS
//================================================================================

localparam [15:0] angle270 = 3 << 14;
localparam [15:0] angle180 = 1 << 15;
localparam [15:0] angle90 = 1 << 14;
parameter [15:0] initValue = 16'h4CCC;

//================================================================================
//  REG/WIRE DECLARATIONS
//================================================================================

wire [15:0] precompAngle [15:0];
wire signed [15:0] xPipe [16:0];
wire signed [15:0] yPipe [16:0];


reg  [15:0] phaseDiffPipe [15:0];
reg  [1:0] SignPipe [15:0];
reg  [1:0] Sign; 
reg   [1:0] SignPrev;

reg signed  [15:0] currPhase;
reg [15:0] phaseAcc;




reg start_flag;



genvar g ;
integer i ;



//================================================================================
//  ASSIGNMENTS
//================================================================================

assign xPipe[0] = initValue; 
assign yPipe[0] = initValue;

assign start_flag_o = start_flag; 




assign precompAngle [0] = 16'd8190;  // theta = 45.000000
assign precompAngle [1] = 16'd4834;   // theta = 22.500000
assign precompAngle [2] = 16'd2554;   // theta = 11.250000
assign precompAngle [3] = 16'd1296;   // theta = 5.625000
assign precompAngle [4] = 16'd650;    // theta = 2.812500
assign precompAngle [5] = 16'd325;    // theta = 1.406250
assign precompAngle [6] = 16'd162;    // theta = 0.703125
assign precompAngle [7] = 16'd81;    // theta = 0.351562
assign precompAngle [8] = 16'd40;     // theta = 0.175781
assign precompAngle [9] = 16'd20;     // theta = 0.087891
assign precompAngle [10] = 16'd10;    // theta = 0.043945
assign precompAngle [11] = 16'd5;     // theta = 0.021973
assign precompAngle [12] = 16'd2;     // theta = 0.010986
assign precompAngle [13] = 16'd1;     // theta = 0.005493
assign precompAngle [14] = 16'd0;     // theta = 0.002747
assign precompAngle [15] = 16'd0;     // theta = 0.001373



always @(posedge Clk_i) begin 
    if (Rst_i ) begin 
        start_flag <= 1'b0;
    end
    else begin 
        if (!Start_i) begin 
            start_flag <= 1'b1;
        end
        else begin 
            start_flag <= 1'b0;
        end
    end
end



always @(posedge Clk_i) begin 
    if (Rst_i) begin 
        phaseAcc <= 16'h0;
    end
    else begin 
        if (start_flag) begin 
            phaseAcc <= phaseAcc + Angle_i;
        end
        else begin 
            phaseAcc <= 16'h0;
        end
    end
end




always @(posedge Clk_i ) begin 
    if (Rst_i) begin 
        currPhase <= 16'h0;
        Sign <= 2'b0;
    end
    else begin 
     if (phaseAcc > angle270 ) begin 
            currPhase <= 16'h0 - phaseAcc;
            Sign <= 2'b10 ;
        end
        else if (phaseAcc > angle180) begin 
            currPhase <= phaseAcc - angle180;
            Sign <= 2'b11;
        end
        else if (phaseAcc > angle90) begin 
            currPhase <= angle180 - phaseAcc;
            Sign <= 2'b01;
        end
        else begin 
            currPhase <= phaseAcc;
            Sign <= 2'b00;
        end
    end
end





always @(posedge Clk_i) begin 
    phaseDiffPipe[0] <= currPhase - precompAngle[0];
    SignPipe[0] <= Sign;
    for (i = 1; i < 16; i = i+1) begin 
        SignPipe[i] <= SignPipe[i-1];
            if (phaseDiffPipe[i-1][15:0]) begin 
                phaseDiffPipe[i] <= phaseDiffPipe[i-1] + precompAngle[i];
            end
            else begin 
                phaseDiffPipe[i] <= phaseDiffPipe[i-1] - precompAngle[i];
            end
    end
end



always @(posedge Clk_i ) begin 
    if (Rst_i) begin 
        Cos_o <= 16'h0;
    end
        else begin 
            if (SignPrev[0] && start_flag) begin 
                Cos_o <= ~xPipe[16] + 1'b1;
            end
            else begin
                if (SignPrev[0]==0 && start_flag) 
                Cos_o <= xPipe[16];
            end
        end
end


generate
always @(posedge Clk_i ) begin 
    if (Rst_i) begin 
        Sine_o <= 16'h0;
    end
    else begin 
        if (SignPrev[1] && start_flag) begin 
            Sine_o <= ~yPipe[16]+ 1'b1 ;
        end
        else begin
            if ((SignPrev[1]==0) && start_flag) begin 
                Sine_o <= yPipe[16];
            end
        end
    end
end
endgenerate


always @(posedge Clk_i) begin 
    if (Rst_i) begin 
        SignPrev <= 2'b0;
    end
    else begin 
        SignPrev <= SignPipe[15];
    end
end


   generate 
        for (g = 0; g < 16 ; g = g + 1 ) begin : cordic_pipeline
         Rot #(
            .ShiftNum(g+1)) 
             Rot_inst (
                .Clk_i(Clk_i),
                .Rst_i(Rst_i),
                .X_i(xPipe[g]),
                .Y_i(yPipe[g]),
                .Sign_i(phaseDiffPipe[g][15]),
                .X_o(xPipe[g+1]),
                .Y_o(yPipe[g+1]),
                .start_flag(start_flag_o)

            );

        end
    endgenerate






endmodule 
