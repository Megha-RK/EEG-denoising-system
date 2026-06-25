module noise_detector(
    input [31:0] energy,
    input [31:0] threshold,
    output noise_flag
);
assign noise_flag = (energy > threshold);
endmodule
