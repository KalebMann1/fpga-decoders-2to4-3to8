// 2-to-4 decoder with active-high enable.
// When en = 1, exactly one output bit is high depending on in[1:0].
// When en = 0, all outputs are 0.
module decoder2to4 (
    input  wire       en,
    input  wire [1:0] in,
    output reg  [3:0] out
);

    always @* begin
        if (!en) begin
            out = 4'b0000;
        end else begin
            case (in)
                2'b00: out = 4'b0001;
                2'b01: out = 4'b0010;
                2'b10: out = 4'b0100;
                2'b11: out = 4'b1000;
                default: out = 4'b0000;
            endcase
        end
    end

endmodule
