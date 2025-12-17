`timescale 1ns/1ps

module tb_decoder3to8;

    reg       en;
    reg [2:0] in;
    wire [7:0] out;

    integer i;

    decoder3to8 dut (
        .en (en),
        .in (in),
        .out(out)
    );

    initial begin
        // Initialize
        en = 0;
        in = 3'b000;

        // Enable the decoder
        #10 en = 1;

        // Sweep all 3-bit inputs
        for (i = 0; i < 8; i = i + 1) begin
            #10 in = i[2:0];
        end

        // Disable again
        #10 en = 0;

        #20 $finish;
    end

endmodule
