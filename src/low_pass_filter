module low_pass_filter #(parameter N=16)(
    input CLK,
    input RST,
    input ENABLE,
    input signed [N-1:0] input_data,
    output signed [N-1:0] output_data
);

    reg signed [N-1:0] prev_data;

    always @(posedge CLK or posedge RST) begin
        if (RST)
            prev_data <= 0;
        else if (ENABLE)
            prev_data <= (prev_data + input_data) >>> 1;
    end

    assign output_data = prev_data;

endmodule
