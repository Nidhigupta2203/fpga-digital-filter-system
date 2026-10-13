module exp_moving_avg_filter #(
    parameter N=16,
    parameter ALPHA=32768
)(
    input CLK,
    input RST,
    input signed [N-1:0] input_data,
    output reg signed [N-1:0] output_data
);

    reg signed [N-1:0] ema;
    reg signed [31:0] calculation;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            ema <= 0;
            output_data <= 0;
            calculation <= 0;
        end else begin
            calculation =
                (ALPHA * input_data)
                + ((65536 - ALPHA) * ema);

            ema <= calculation >>> 16;
            output_data <= calculation >>> 16;
        end
    end

endmodule
