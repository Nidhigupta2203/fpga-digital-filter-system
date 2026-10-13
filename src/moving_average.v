module moving_average #(
    parameter N=16,
    parameter WINDOW=4
)(
    input CLK,
    input RST,
    input signed [N-1:0] input_data,
    output signed [N-1:0] output_data
);

    reg signed [N-1:0] samples [0:WINDOW-1];
    reg signed [N+$clog2(WINDOW):0] sum;
    integer i;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            sum <= 0;
            for (i=0; i<WINDOW; i=i+1)
                samples[i] <= 0;
        end else begin
            sum <= sum - samples[WINDOW-1] + input_data;

            for (i=WINDOW-1; i>0; i=i-1)
                samples[i] <= samples[i-1];

            samples[0] <= input_data;
        end
    end

    assign output_data = sum / WINDOW;

endmodule
