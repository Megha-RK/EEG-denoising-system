`timescale 1ns/1ps

module tb();
    reg clk;
    reg rst;
    reg signed [15:0] eeg_in;
    wire signed [15:0] eeg_out;
    wire noise_flag;
    wire [31:0] energy;
    wire [31:0] mean_energy;
    wire [31:0] threshold;
    wire done;
    integer infile;
    integer status;
    eeg_denoiser_top dut (
        .clk(clk),
        .rst(rst),
        .eeg_in(eeg_in),
        .eeg_out(eeg_out),
        .noise_flag(noise_flag),
        .energy(energy),
        .mean_energy(mean_energy),
        .threshold(threshold),
        .done(done)
    );
    always #5 clk = ~clk;
    initial begin  
   $dumpfile("eeg.vcd");
  $dumpvars(0, tb_eeg);

  clk = 0;
  rst = 1;
  eeg_in = 0;
#20;
  rst = 0;
        infile = $fopen("eeg_samples.txt", "r");
        if (infile == 0) begin
            $display("ERROR: Cannot open eeg_samples.txt! Check file location.");
            $finish;
        end
        status = $fscanf(infile, "%d\n", eeg_in);
    while (status == 1) begin
       @(posedge clk);
      status = $fscanf(infile, "%d\n", eeg_in);
     end
      $fclose(infile);
        repeat(500) @(posedge clk);
   $display("Simulation Complete");
 $finish;
end  
  always @(posedge clk) begin
    $display("time = %0d, clk = %b,  rst = %b, eeg_in = %d, eeg_out = %d, energy = %d, noise_flag = %b",$time, clk, rst, eeg_in, eeg_out, energy, noise_flag);
   end

endmodule

