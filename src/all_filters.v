module all_filters #(parameter N=16, WINDOW=4)(
    input CLK,
    input RST,
    input ENABLE,
    input signed [N-1:0] input_data,
    input [3:0] filter_select,
    output signed [N-1:0] output_data
);

    wire signed [N-1:0] fir_out, iir_out;
    wire signed [N-1:0] median_out, mov_avg_out;
    wire signed [N-1:0] high_pass_out, low_pass_out;
    wire signed [N-1:0] band_pass_out, notch_out;
    wire signed [N-1:0] exp_mov_avg_out;

    fir_filter #(N) fir_inst (
        .CLK(CLK), .RST(RST), .ENABLE(ENABLE),
        .input_data(input_data), .output_data(fir_out)
    );

    iir_filter #(N) iir_inst (
        .CLK(CLK), .RST(RST), .ENABLE(ENABLE),
        .input_data(input_data), .output_data(iir_out)
    );

    median_filter #(N) median_inst (
        .CLK(CLK), .RST(RST),
        .input_data(input_data), .output_data(median_out)
    );

    moving_average #(N, WINDOW) mov_avg_inst (
        .CLK(CLK), .RST(RST),
        .input_data(input_data), .output_data(mov_avg_out)
    );

    high_pass_filter #(N) high_pass_inst (
        .CLK(CLK), .RST(RST), .ENABLE(ENABLE),
        .input_data(input_data), .output_data(high_pass_out)
    );

    low_pass_filter #(N) low_pass_inst (
        .CLK(CLK), .RST(RST), .ENABLE(ENABLE),
        .input_data(input_data), .output_data(low_pass_out)
    );

    band_pass_filter #(N) band_pass_inst (
        .CLK(CLK), .RST(RST), .ENABLE(ENABLE),
        .input_data(input_data), .output_data(band_pass_out)
    );

    notch_filter #(N) notch_inst (
        .CLK(CLK), .RST(RST), .ENABLE(ENABLE),
        .input_data(input_data), .output_data(notch_out)
    );

    exp_moving_avg_filter #(N) exp_mov_avg_inst (
        .CLK(CLK), .RST(RST),
        .input_data(input_data), .output_data(exp_mov_avg_out)
    );

    assign output_data =
        (filter_select == 4'b0000) ? fir_out :
        (filter_select == 4'b0001) ? iir_out :
        (filter_select == 4'b0010) ? median_out :
        (filter_select == 4'b0011) ? mov_avg_out :
        (filter_select == 4'b0100) ? high_pass_out :
        (filter_select == 4'b0101) ? low_pass_out :
        (filter_select == 4'b0110) ? band_pass_out :
        (filter_select == 4'b0111) ? notch_out :
        (filter_select == 4'b1000) ? exp_mov_avg_out :
        {N{1'b0}};

endmodule
