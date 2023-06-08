/*
    NCO module.
    The module implements CORDIC algorithm
*/

module CORDICNCO (
    clk_i,
    rst_i,
    val_i,
    phase_inc_i,
    cos_o,
    sin_o,
    val_o
    );

//================================================================================
//
//  PARAMETER/LOCALPARAM DECLARATIONS
//
//================================================================================

    parameter                   ODAT_W              = 16;
    parameter                   P_INC_W             = 16;
    parameter                   ITER_NUM            = 16;
    parameter                   EN_SIN_N            = 0;

    localparam  [P_INC_W-1:0]   ANGLE_270_DEGREE    = 3<<(P_INC_W-2);
    localparam  [P_INC_W-1:0]   ANGLE_180_DEGREE    = 1<<(P_INC_W-1);
    localparam  [P_INC_W-1:0]   ANGLE_90_DEGREE     = 1<<(P_INC_W-2);
    localparam [15:0] INIT_VALUE = 16'h4CCC;

//================================================================================
//
//  PORTS DECLARATIONS
//
//================================================================================

    input                           clk_i;
    input                           rst_i;
    input                           val_i;
    input           [P_INC_W-1:0]   phase_inc_i;
    output  reg     [ODAT_W-1:0]    cos_o;
    output  reg     [ODAT_W-1:0]    sin_o;
    output  reg                     val_o;

//================================================================================
//
//  REG/WIRE DECLARATIONS
//
//================================================================================

    wire    [P_INC_W-1:0]           precompAngle[ODAT_W-1:0];
    wire    [ODAT_W-1:0]            x_pipe[ITER_NUM:0];
    wire    [ODAT_W-1:0]            y_pipe[ITER_NUM:0];
    wire    [ITER_NUM:0]            val_pipe;
    reg     [P_INC_W-1:0]           phase_diff_pipe[ITER_NUM-1:0];
    reg     [1:0]                   sc_sign_pipe[ITER_NUM-1:0];

    reg     [P_INC_W-1:0]           phase_accumulator;
    reg     [P_INC_W-1:0]           current_phase;
    reg     [1:0]                   sc_sign_prev;
    reg     [1:0]                   sc_sign;
    reg     [2:0]                   val_sr;

    genvar  g;
    integer i;

//================================================================================
//
//  ASSIGNMENTS
//
//================================================================================

    assign  x_pipe[0]   = INIT_VALUE;
    assign  y_pipe[0]   = INIT_VALUE;
    assign  val_pipe[0] = val_sr[2];

//================================================================================
//
//  CODING
//
//================================================================================

//  For apropriate reference file checking

/*initial begin
    if ((FILE_ODAT_W != ODAT_W) || (FILE_P_INC_W != P_INC_W) || (FILE_ITER_NUM != ITER_NUM)) begin
        $error("Invalid reference file. Please, check module's parameters, %b%b%b", (FILE_ODAT_W != ODAT_W), (FILE_P_INC_W != P_INC_W), (FILE_ITER_NUM != ITER_NUM));
        $stop;
    end
end*/

//--------------------------------------------------------------------------------
//
//  Phase handle logic
//

always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        phase_accumulator   <= {P_INC_W{1'b0}};
    end else if (val_i) begin
        phase_accumulator   <= phase_accumulator + phase_inc_i;
    end
end


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

always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        current_phase   <= {P_INC_W{1'b0}};
        sc_sign         <= 2'b0;
    end else begin
        if (phase_accumulator > ANGLE_270_DEGREE) begin
            current_phase   <= {P_INC_W{1'b0}} - phase_accumulator;
            sc_sign         <= 2'b10;
        end else if (phase_accumulator > ANGLE_180_DEGREE) begin
            current_phase   <= phase_accumulator - ANGLE_180_DEGREE;
            sc_sign         <= 2'b11;
        end else if (phase_accumulator > ANGLE_90_DEGREE) begin
            current_phase   <= ANGLE_180_DEGREE - phase_accumulator;
            sc_sign         <= 2'b01;
        end else begin
            current_phase   <= phase_accumulator;
            sc_sign         <= 2'b00;
        end
    end
end

//--------------------------------------------------------------------------------
//
//  CORDIC pipe
//

always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        val_sr <= 3'b0;
    end else begin
        val_sr <= {val_sr[1:0], val_i};
    end
end

always @(posedge clk_i) begin
    phase_diff_pipe[0]  <= current_phase - precompAngle[0];
    sc_sign_pipe[0]     <= sc_sign;
    for(i=1; i<ITER_NUM; i=i+1) begin
        sc_sign_pipe[i] <= sc_sign_pipe[i-1];
        if (phase_diff_pipe[i-1][P_INC_W-1]) begin
            phase_diff_pipe[i] <= phase_diff_pipe[i-1] + precompAngle[i];
        end else begin
            phase_diff_pipe[i] <= phase_diff_pipe[i-1] - precompAngle[i];
        end
    end
end

generate
    for (g = 0; g < ITER_NUM; g = g + 1) begin : cordic_pipe
        CORDICROT #(
            .ODAT_W     (ODAT_W),
            .SHIFT      (g+1)
        ) cordic_rotation_inst (
            .Clk_i      (clk_i),
            .Rst_i      (rst_i),
            .X_i        (x_pipe[g]),
            .Y_i        (y_pipe[g]),
            .Val_i      (val_pipe[g]),
            .Sign_i     (phase_diff_pipe[g][P_INC_W-1]),
            .X_o        (x_pipe[g+1]),
            .Y_o        (y_pipe[g+1]),
            .Val_o      (val_pipe[g+1])
            );
    end
endgenerate

//--------------------------------------------------------------------------------
//
//  Output logic
//

generate 
    if (EN_SIN_N) begin
        always @(posedge clk_i or posedge rst_i) begin
            if (rst_i) begin
                sin_o       <= {ODAT_W{1'b0}};
            end else begin
                if (sc_sign_prev[1]) begin
                    sin_o   <=  y_pipe[ITER_NUM];
                end else begin
                    sin_o   <= ~y_pipe[ITER_NUM] + {{(ODAT_W-1){1'b0}}, 1'b1};
                end
            end
        end
    end else begin
        always @(posedge clk_i or posedge rst_i) begin
            if (rst_i) begin
                sin_o       <= {ODAT_W{1'b0}};
            end else begin
                if (sc_sign_prev[1]) begin
                    sin_o   <= ~y_pipe[ITER_NUM] + {{(ODAT_W-1){1'b0}}, 1'b1};
                end else begin
                    sin_o   <=  y_pipe[ITER_NUM];
                end
            end
        end
    end
endgenerate

always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        cos_o           <= {ODAT_W{1'b0}};
        sc_sign_prev    <= 2'b0;
        val_o           <= 1'b0;
    end else begin
        if (sc_sign_prev[0]) begin
            cos_o   <= ~x_pipe[ITER_NUM] + {{(ODAT_W-1){1'b0}}, 1'b1};
        end else begin
            cos_o   <= x_pipe[ITER_NUM];
        end
        sc_sign_prev    <= sc_sign_pipe[ITER_NUM-1];
        val_o           <= val_pipe[ITER_NUM];
    end
end

endmodule
