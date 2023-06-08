

module Sine #(parameter ODatWidth = 16,
                parameter PhIncWidth = 16) 
(
    input Clk_i,
    input Rst_i,
    input  [PhIncWidth-1:0] PhInc_i,
    // input Start_i,
    input Val_i,

    output reg signed [ODatWidth-1:0] Sine_o,
    output reg Done_o,
    output  reg   [ODatWidth-1:0] Cos_o ,
    output reg Val_o,
    output reg ValW_o
);

//================================================================================
//  LOCALPARAMS
//================================================================================

localparam [PhIncWidth-1:0] angle270 = 3 << (PhIncWidth-2);
localparam [PhIncWidth-1:0] angle180 = 1 << (PhIncWidth-1);
localparam [PhIncWidth-1:0] angle90 = 1 << (PhIncWidth-2);

parameter [ODatWidth:0] initValue = 16'h4CCC;
// parameter ODatWidth = 16;
// parameter PhIncWidth = 16;
parameter IterNum = 16;
parameter EnSinN = 0;
parameter EnSinW = 0; 



//================================================================================
//  REG/WIRE DECLARATIONS
//================================================================================

wire [PhIncWidth-1:0] precompAngle [ODatWidth-1:0];
wire  [ODatWidth-1:0] xPipe [IterNum:0];
wire  [ODatWidth-1:0] yPipe [IterNum:0];
wire [IterNum:0] valPipe;
reg  [PhIncWidth-1:0] phaseDiffPipe [IterNum-1:0];
reg  [1:0] SignPipe [IterNum-1:0];



reg  [1:0] Sign; 
reg   [1:0] SignPrev;

reg   [PhIncWidth-1:0] currPhase;
reg [PhIncWidth-1:0] phaseAcc;
reg [2:0 ] valSr;
reg [9:0] cnt;
reg iter; 




reg start_flag;



genvar g ;
integer i ;



//================================================================================
//  ASSIGNMENTS
//================================================================================

assign xPipe[0] = initValue; 
assign yPipe[0] = initValue;
assign valPipe[0] = valSr[2];
assign ValW = (!iter)? 1'b1:1'b0;



// assign start_flag_o = start_flag; 




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






always @(posedge Clk_i or posedge Rst_i) begin 
    if (Rst_i) begin 
        phaseAcc <= {PhIncWidth{1'b0}};
    end
    else begin 
        if (Val_i) begin 
            phaseAcc <= phaseAcc + PhInc_i;
        end
    end
end



always @(posedge Clk_i) begin 
    if (Rst_i) begin 
        iter <= 1'b0;
    end
    else begin 
        if (cnt == 10'd1024) begin 
            iter <= 1'b1;
        end
        else begin 
            iter <= 1'b0;
        end
    end
end



always @(posedge Clk_i) begin 
    if (Rst_i) begin 
        cnt <= 10'h0;
    end
    else begin 
        if ((Sine_o != 16'h0) && (!iter)&& (EnSinW == 0)) begin 
            cnt <= cnt + 10'h1;
        end
        else begin 
            if (iter) begin 
                cnt <= 10'h0;
            end
        end
    end
end

always @(posedge Clk_i or posedge Rst_i ) begin 
    if (Rst_i) begin 
        currPhase <= {PhIncWidth{1'b0}};
        Sign <= 2'b0;
    end
    else begin 
     if (phaseAcc > angle270 ) begin 
            currPhase <= {PhIncWidth{1'b0}} - phaseAcc;
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


//================================================================================
//  PIPE
//================================================================================


always @(posedge Clk_i) begin
    if (Rst_i) begin 
        valSr <= 3'b0;
    end
    else begin 
        valSr <= {valSr[1:0], Val_i};
    end
end


always @(posedge Clk_i) begin 
    phaseDiffPipe[0] <= currPhase - precompAngle[0];
    SignPipe[0] <= Sign;
    for (i = 1; i < IterNum; i = i+1) begin 
        SignPipe[i] <= SignPipe[i-1];
            if (phaseDiffPipe[i-1][PhIncWidth-1]) begin 
                phaseDiffPipe[i] <= phaseDiffPipe[i-1] + precompAngle[i];
            end
            else begin 
                phaseDiffPipe[i] <= phaseDiffPipe[i-1] - precompAngle[i];
            end
    end
end



//    generate 
//         for (g = 0; g < IterNum ; g = g + 1 ) begin : cordic_pipeline
//          Rot #(
//             .ODatWidth(ODatWidth),
//             .ShiftNum(g+1)) 
//              Rot_inst (
//                 .Clk_i(Clk_i),
//                 .Rst_i(Rst_i),
//                 .X_i(xPipe[g]),
//                 .Y_i(yPipe[g]),
//                 .Val_i(valPipe[g]),
//                 .Sign_i(phaseDiffPipe[g][PhIncWidth-1]),
//                 .X_o(xPipe[g+1]),
//                 .Y_o(yPipe[g+1]),
//                 .Val_o(valPipe[g+1])

//             );

//         end
//     endgenerate

    generate 
        for (g =0; g < IterNum; g = g + 1) begin : cordic_pipeline
            CORDICROT #(
                .ODAT_W(ODatWidth),
                .SHIFT(g+1))
            CORDICROT_inst (
                .Clk_i(Clk_i),
                .Rst_i(Rst_i),
                .X_i(xPipe[g]),
                .Y_i(yPipe[g]),
                .Val_i(valPipe[g]),
                .Sign_i(phaseDiffPipe[g][PhIncWidth-1]),
                .X_o(xPipe[g+1]),
                .Y_o(yPipe[g+1]),
                .Val_o(valPipe[g+1])
            );

        end
    endgenerate

generate
    if (EnSinN) begin 
        always @(posedge Clk_i) begin 
            if (Rst_i) begin 
                Sine_o <= {ODatWidth{1'b0}};
            end
            else begin 
                if (SignPrev[1]) begin 
                    Sine_o <= yPipe[IterNum];
                end
                else begin 
                    Sine_o <= ~yPipe[IterNum] + {{(ODatWidth-1){1'b0}},1'b1};
                end
            end
        end
    end
    else begin
always @(posedge Clk_i ) begin 
    if (Rst_i) begin 
        Sine_o <= {ODatWidth{1'b0}};
    end
    else begin 
        if (SignPrev[1]) begin 
            Sine_o <= ~yPipe[IterNum]+ {{(ODatWidth-1){1'b0}},1'b1} ;
        end
        else begin 
                Sine_o <= yPipe[IterNum];
            end
    end
end
    end
endgenerate

always @(posedge Clk_i ) begin 
    if (Rst_i) begin 
        Cos_o <= {ODatWidth{1'b0}};
        SignPrev <= 2'b0;
        Val_o <= 1'b0;
    end
        else begin 
            if (SignPrev[0]) begin 
                Cos_o <= ~xPipe[IterNum] + {{(ODatWidth-1){1'b0}},1'b1};
            end
            else begin
                Cos_o <= xPipe[IterNum];
            end
            SignPrev <= SignPipe[IterNum-1];
            Val_o <= valPipe[IterNum];
        end
end





endmodule 
