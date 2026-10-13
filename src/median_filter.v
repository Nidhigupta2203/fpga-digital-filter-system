module median_filter #(parameter N=16)(
    input CLK,
    input RST,
    input signed [N-1:0] input_data,
    output signed [N-1:0] output_data
);

    reg signed [N-1:0] s0, s1, s2;
    reg signed [N-1:0] median_value;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            s0 <= 0;
            s1 <= 0;
            s2 <= 0;
        end else begin
            s0 <= input_data;
            s1 <= s0;
            s2 <= s1;
        end
    end

    always @(*) begin
        if ((s0 >= s1 && s0 <= s2) ||
            (s0 <= s1 && s0 >= s2))
            median_value = s0;
        else if ((s1 >= s0 && s1 <= s2) ||
                 (s1 <= s0 && s1 >= s2))
            median_value = s1;
        else
            median_value = s2;
    end

    assign output_data = median_value;

endmodule
