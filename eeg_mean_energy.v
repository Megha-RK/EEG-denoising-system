module mean_energy_calc(
    input clk,
    input rst,
    input [31:0] energy,
    input done,
    output reg [31:0] mean_energy
);
reg [31:0] e0,e1,e2,e3,e4,e5,e6,e7;
reg [34:0] sum;
always @(posedge clk or posedge rst) begin
if(rst) begin
 e0<=0; e1<=0; e2<=0; e3<=0; e4<=0; e5<=0; e6<=0; e7<=0;
  mean_energy <= 0;
 end
else if(done) 
  begin
  e7 <= e6;
 e6 <= e5;
e5 <= e4;
e4 <= e3;
e3 <= e2; 
e2 <= e1;
 e1 <= e0;
e0 <= energy;
sum = e0+e1+e2+e3+e4+e5+e6+e7;
 mean_energy <= sum >> 3;
end
  end
endmodule
