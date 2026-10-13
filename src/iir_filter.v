module iir_filter #(parameter N=16)(
    input CLK,
    input RST,
    input ENABLE,
    input signed [N-1:0] input_data,
    output signed [N-1:0] output_data
);

    parameter signed [N-1:0] a1 = 16'sd16384;
    parameter signed [N-1:0] b0 = 16'sd8192;

    reg signed [N-1:0] y_prev;

    always @(posedge CLK or posedge RST) begin
        if (RST)
            y_prev <= 0;
        else if (ENABLE)
            y_prev <= (b0 * input_data - a1 * y_prev) >>> 14;
    end

    assign output_data = y_prev;

endmodule
