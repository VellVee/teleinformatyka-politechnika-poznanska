module some_test();

reg clk;
reg r_w;
integer push;
wire [31:0] pop;

always begin

#1 clk = !clk;

end

initial begin

clk = 0;

#1 r_w = 0;

#1 push = 'd9;

#10
$finish;

end

some some(clk,r_w,push,pop);

endmodule