module bandpass_filter (
    input clk,
    input rst,
    input signed [15:0] eeg_in,
    output reg signed [15:0] bandpass_out
);
  integer i;
    reg signed [15:0] x [0:30];
    wire signed [15:0] coeff [0:30];
    assign coeff[0]  = 16'sd1; 
    assign coeff[1]  = 16'sd2; 
    assign coeff[2]  = 16'sd0;    
    assign coeff[3]  = -16'sd4;
    assign coeff[4]  = -16'sd8; 
    assign coeff[5]  = -16'sd5;   
    assign coeff[6]  = 16'sd6; 
    assign coeff[7]  = 16'sd18; 
    assign coeff[8]  = 16'sd13;   
    assign coeff[9]  = -16'sd17;
    assign coeff[10] = -16'sd52; 
    assign coeff[11] = -16'sd52;  
    assign coeff[12] = 16'sd16; 
    assign coeff[13] = 16'sd140; 
    assign coeff[14] = 16'sd264;  
    assign coeff[15] = 16'sd315;
    assign coeff[16] = 16'sd264; 
    assign coeff[17] = 16'sd140;  
    assign coeff[18] = 16'sd16;  
    assign coeff[19] = -16'sd52;  
    assign coeff[20] = -16'sd52;  
    assign coeff[21] = -16'sd17; 
    assign coeff[22] = 16'sd13;
    assign coeff[23] = 16'sd18;   
    assign coeff[24] = 16'sd6;  
    assign coeff[25] = -16'sd5; 
    assign coeff[26] = -16'sd8;   
    assign coeff[27] = -16'sd4; 
    assign coeff[28] = 16'sd0;  
    assign coeff[29] = 16'sd2;    
    assign coeff[30] = 16'sd1;
  
reg signed [31:0] products [0:30];
reg signed [32:0] tree_lvl1 [0:15]; 
 reg signed [33:0] tree_lvl2 [0:7];  
 reg signed [34:0] tree_lvl3 [0:3];  
  reg signed [35:0] tree_lvl4 [0:1];  
 reg signed [47:0] acc;              

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            for(i=0; i<31; i=i+1) begin
                x[i] <= 0;
                products[i] <= 0;
            end
            for(i=0; i<16; i=i+1) tree_lvl1[i] <= 0;
            for(i=0; i<8;  i=i+1) tree_lvl2[i] <= 0;
            for(i=0; i<4;  i=i+1) tree_lvl3[i] <= 0;
            tree_lvl4[0] <= 0; 
            tree_lvl4[1] <= 0;
            acc <= 0;
            bandpass_out <= 0;
        end
        else begin
            for(i=30; i>0; i=i-1)
                x[i] <= x[i-1];
            x[0] <= eeg_in;
            for(i=0; i<31; i=i+1)
                products[i] <= x[i] * coeff[i];
            for(i=0; i<15; i=i+1)
                tree_lvl1[i] <= products[i*2] + products[(i*2)+1];
            tree_lvl1[15] <= products[30]; 
            for(i=0; i<8; i=i+1)
                tree_lvl2[i] <= tree_lvl1[i*2] + tree_lvl1[(i*2)+1];
            for(i=0; i<4; i=i+1)
                tree_lvl3[i] <= tree_lvl2[i*2] + tree_lvl2[(i*2)+1];
            tree_lvl4[0] <= tree_lvl3[0] + tree_lvl3[1];
            tree_lvl4[1] <= tree_lvl3[2] + tree_lvl3[3];
            acc <= tree_lvl4[0] + tree_lvl4[1];
            bandpass_out <= acc >>> 10;
        end
       end
    endmodule

