module band_pass_filter #(parameter N=16)(
    input CLK,
    input RST,
    input ENABLE,
    input signed [N-1:0] input_data,
    output signed [N-1:0] output_data
);

    reg signed [N-1:0] low_pass;
    reg signed [N-1:0] high_pass;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            low_pass <= 0;
            high_pass <= 0;
        end else if (ENABLE) begin
            low_pass <= (low_pass + input_data) >>> 1;
            high_pass <= input_data - low_pass;
        end
    end

    assign output_data = high_pass;

endmodule
