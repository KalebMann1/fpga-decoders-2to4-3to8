`timescale 1ns/1ps

module tb_decoder2to4;

    reg       en;
    reg [1:0] in;
    wire [3:0] out;

    integer i;

    decoder2to4 dut (
        .en (en),
        .in (in),
        .out(out)
    );

    initial begin
        // Initialize
        en = 0;
        in = 2'b00;

        // Check disabled behavior
        #10;
        en = 1;

        // Sweep all input combinations
        for (i = 0; i < 4; i = i + 1) begin
            #10 in = i[1:0];
        end

        // Disable again
        #10 en = 0;

        #20 $finish;
    end

endmodule
