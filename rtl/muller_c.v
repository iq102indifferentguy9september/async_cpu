// Написан на чистом Verilog-2001/2005
module muller_c (
    input  a,
    input  b,
    input  rst_n,
    output q
);
    
    (* keep = "true" *) wire q_internal;
    
    assign q_internal = ((a & b) | ((a | b) & q_internal)) & rst_n;
    assign q          = q_internal;
    
endmodule