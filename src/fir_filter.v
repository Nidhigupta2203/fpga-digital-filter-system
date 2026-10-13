module fir_filter #(parameter N=16)(
    input CLK,
    input RST,
    input ENABLE,
    input signed [N-1:0] input_data,
    output reg signed [N-1:0] output_data
);

    reg signed [N-1:0] x1, x2, x3;
    reg signed [N+1:0] sum;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            x1 <= 0;
            x2 <= 0;
            x3 <= 0;
            output_data <= 0;
        end else if (ENABLE) begin
            sum = {{2{input_data[N-1]}}, input_data}
                + {{2{x1[N-1]}}, x1}
                + {{2{x2[N-1]}}, x2}
                + {{2{x3[N-1]}}, x3};

            output_data <= sum >>> 2;

            x3 <= x2;
            x2 <= x1;
            x1 <= input_data;
        end
    end

endmodule
