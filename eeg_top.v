module eeg_denoiser_top(
    input clk,
    input rst,
    input signed [15:0] eeg_in,
   output signed [15:0] eeg_out,
    output noise_flag,
    output [31:0] energy,
    output [31:0] mean_energy,
    output [31:0] threshold,
    output done
);
wire signed [15:0] bp_out;
wire signed [15:0] notch_out;
wire [31:0] energy_wire;
wire [31:0] mean_energy_wire;
wire [31:0] threshold_wire;
wire done_wire;
wire noise_flag_wire;
reg signed [15:0] bp_reg;
reg signed [15:0] notch_reg;
reg [31:0] energy_reg;
reg [31:0] mean_energy_reg;
bandpass_filter bp (
    .clk(clk),
    .rst(rst),
    .eeg_in(eeg_in),
    .bandpass_out(bp_out)
);
always @(posedge clk or posedge rst) begin
    if(rst)
        bp_reg <= 0;
    else
        bp_reg <= bp_out;
end
notch_filter nf (
    .clk(clk),
    .rst(rst),
    .eeg_in(bp_reg),
    .notch_out(notch_out)
);
always @(posedge clk or posedge rst) begin
    if(rst)
        notch_reg <= 0;
    else
        notch_reg <= notch_out;
end
assign eeg_out = notch_reg;
energy_calculator ec (
    .clk(clk),
    .rst(rst),
    .eeg_in(notch_reg),
    .energy(energy_wire),
    .done(done_wire)
);
always @(posedge clk or posedge rst) begin
    if(rst)
        energy_reg <= 0;
    else if(done_wire)
        energy_reg <= energy_wire;
end
mean_energy_calc mc (
    .clk(clk),
    .rst(rst),
    .energy(energy_reg),
    .done(done_wire),
    .mean_energy(mean_energy_wire)
);
always @(posedge clk or posedge rst) begin
    if(rst)
        mean_energy_reg <= 0;
    else
        mean_energy_reg <= mean_energy_wire;
end
adaptive_threshold at (
    .mean_energy(mean_energy_reg),
    .threshold(threshold_wire)
);
noise_detector nd (
    .energy(energy_reg),
    .threshold(threshold_wire),
    .noise_flag(noise_flag_wire)
);
assign energy      = energy_reg;
assign mean_energy = mean_energy_reg;
assign threshold   = threshold_wire;
assign noise_flag  = noise_flag_wire;
assign done = done_wire;
endmodule

