module energy_calculator (
    input clk,
    input rst,
    input signed [15:0] eeg_in,
    output reg [31:0] energy,
    output reg done
);
reg [31:0] accumulator;
    reg [7:0] sample_count;
 wire [31:0] square;
assign square = eeg_in * eeg_in;
  always @(posedge clk or posedge rst) begin
        if(rst) begin
            accumulator <= 0;
            sample_count <= 0;
            energy <= 0;
            done <= 0;
        end
      else begin
            done <= 0;
            accumulator <= accumulator + square;
            if(sample_count == 8'd255) begin
                energy <= accumulator + square;
                accumulator  <= 0;
                sample_count <= 0;
              done <= 1;
            end
            else begin
         sample_count <= sample_count + 1;
            end
          end
        end
endmodule

