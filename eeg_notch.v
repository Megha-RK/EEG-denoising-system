module notch_filter (
    input clk,
    input rst,
    input signed [15:0] eeg_in,
    output reg signed [15:0] notch_out
);
    integer i;
    reg signed [15:0] x [0:30];
    reg signed [15:0] coeff [0:30];
    reg signed [47:0] acc;
    initial begin
    coeff[0]  = -1;
    coeff[1]  = 0;
    coeff[2]  = 2;
    coeff[3]  = 1;
    coeff[4]  = -2;
    coeff[5]  = -5;
    coeff[6]  = 0;
    coeff[7]  = 7;
    coeff[8]  = 6;
    coeff[9]  = -5;
    coeff[10] = -12;
    coeff[11] = -3;
    coeff[12] = 13;
    coeff[13] = 12;
    coeff[14] = -5;
    coeff[15] = 1009;
    coeff[16] = -5;
    coeff[17] = 12;
    coeff[18] = 13;
    coeff[19] = -3;
    coeff[20] = -12;
    coeff[21] = -5;
    coeff[22] = 6;
    coeff[23] = 7;
    coeff[24] = 0;
    coeff[25] = -5;
    coeff[26] = -2;
    coeff[27] = 1;
    coeff[28] = 2;
    coeff[29] = 0;
    coeff[30] = -1;
    end
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            for(i=0;i<31;i=i+1)
                x[i] <= 0;
            notch_out <= 0;
        end
        else begin
            for(i=30;i>0;i=i-1)
                x[i] <= x[i-1];
            x[0] <= eeg_in;
          acc = 0;
            for(i=0;i<31;i=i+1)
                acc = acc + x[i] * coeff[i];
            notch_out <= acc >>> 10;
      end
    end
   endmodule

