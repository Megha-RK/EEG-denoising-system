module adaptive_threshold(
    input [31:0] mean_energy,
    output [31:0] threshold
);
assign threshold = mean_energy + (mean_energy >> 1);
endmodule

