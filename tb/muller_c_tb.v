`timescale 1ns/1ps
module testbench;
    reg  a, b, rst_n;
    wire q;
    integer i, j, errors;
    reg expected;

muller_c dut (.a(a),.b(b),.rst_n(rst_n),.q(q));
initial begin
    errors = 0;
    for (j = 0; j < 2; j = j + 1) begin
        for (i = 0; i<8; i = i + 1) begin
            //привести q в нужное состояние
            rst_n = 0; a = 0; b = 0; #5;
            if (j==1) begin
                rst_n = 1; a = 1; b = 1; #5;
            end
            //подать комбинацию
            {rst_n, a, b} = i; #5;
            // эталон
            expected = !rst_n ? 1'b0 : (a == b) ? a : j[0]; // rst_n ? ((a & b) | ((a | b) & j[0])) : 1'b0;
            if (q !== expected) begin
                errors = errors + 1;
                $display("FAIL: q_prev=%0d rst_n=%b a=%b b=%b -> q=%b, expected %b",j, rst_n, a, b, q, expected);
                end
            end
        end
        if (errors == 0) $display("ALL 16 CASES PASSED");
        else             $display("ERRORS: %0d", errors);
        $finish;
    end
endmodule