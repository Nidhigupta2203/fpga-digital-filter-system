`timescale 1ns / 1ps

module tb_all_filters;

    parameter N = 16;
    parameter WINDOW = 4;
    parameter SAMPLES = 100;
    parameter NUM_FILTERS = 9;

    reg CLK;
    reg RST;
    reg ENABLE;
    reg signed [N-1:0] input_data;
    reg [3:0] filter_select;

    wire signed [N-1:0] output_data;

    reg signed [N-1:0] sample_data [0:SAMPLES-1];
    integer output_file;
    integer i, j;

    all_filters #(N, WINDOW) dut (
        .CLK(CLK),
        .RST(RST),
        .ENABLE(ENABLE),
        .input_data(input_data),
        .filter_select(filter_select),
        .output_data(output_data)
    );

    initial CLK = 0;
    always #5 CLK = ~CLK;

    initial begin
        RST = 1;
        ENABLE = 0;
        input_data = 0;
        filter_select = 0;

        $readmemb("Input_data.mem", sample_data);

        output_file = $fopen("filter_comparison.txt", "w");

        if (output_file == 0) begin
            $display("ERROR: Unable to open output file.");
            $finish;
        end

        $fwrite(output_file,
                "Sample,Input,Filter,Output\n");

        for (j = 0; j < NUM_FILTERS; j = j + 1) begin

            filter_select = j;
            RST = 1;
            ENABLE = 0;
            input_data = 0;

            repeat (2) @(negedge CLK);

            RST = 0;
            ENABLE = 1;

            for (i = 0; i < SAMPLES; i = i + 1) begin
                input_data = sample_data[i];

                @(posedge CLK);
                #1;

                $fwrite(output_file, "%0d,%0d,%0d,%0d\n",
                        i, $signed(input_data),
                        j, $signed(output_data));
            end

            ENABLE = 0;
        end

        $fclose(output_file);

        $display("Simulation finished.");
        $display("Results saved to filter_comparison.txt");

        $finish;
    end

endmodule
