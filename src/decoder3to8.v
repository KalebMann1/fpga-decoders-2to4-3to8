// 3-to-8 decoder with active-high enable.
// Implemented hierarchically using two 2-to-4 decoders.
module decoder3to8 (
    input  wire       en,
    input  wire [2:0] in,
    output wire [7:0] out
);
    wire en_low;
    wire en_high;
    wire [1:0] in_low;

    assign in_low  = in[1:0];       // lower 2 bits
    assign en_low  = en & ~in[2];   // enable when MSB = 0
    assign en_high = en &  in[2];   // enable when MSB = 1

    wire [3:0] out_low;
    wire [3:0] out_high;

    decoder2to4 dec_low (
        .en (en_low),
        .in (in_low),
        .out(out_low)
    );

    decoder2to4 dec_high (
        .en (en_high),
        .in (in_low),
        .out(out_high)
    );

    assign out = {out_high, out_low};

endmodule
