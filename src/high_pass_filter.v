module high_pass_filter #(parameter N=16)(
    input CLK,
    input RST,
    input ENABLE,
    input signed [N-1:0] input_data,
    output signed [N-1:0] output_data
);

    reg signed [N-1:0] prev_input;
    reg signed [N-1:0] prev_output;

    wire signed [N-1:0] diff;

    assign diff = input_data - prev_input + (prev_output >>> 1);

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            prev_input <= 0;
            prev_output <= 0;
        end else if (ENABLE) begin
            prev_output <= diff;
            prev_input <= input_data;
        end
    end

    assign output_data = prev_output;

endmodule
