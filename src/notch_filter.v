module notch_filter #(parameter N=16)(
    input CLK,
    input RST,
    input ENABLE,
    input signed [N-1:0] input_data,
    output signed [N-1:0] output_data
);

    reg signed [N-1:0] notch;

    always @(posedge CLK or posedge RST) begin
        if (RST)
            notch <= 0;
        else if (ENABLE)
            notch <= input_data - (input_data >>> 4);
    end

    assign output_data = notch;

endmodule
