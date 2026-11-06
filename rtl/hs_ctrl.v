// Написан на чистом верилог
module hs_ctrl ( input  rst_n,

                 output left_ack,
                 input  left_reg,
                 
                 input  right_ack,
                 output right_reg,
                 
                 output gate_en        
);

    (* keep = "true" *) wire next_ready;
   
    assign next_ready = ~right_ack;

    muller_c ctrl (.a     (left_reg),
                   .b     (next_ready),
                   .rst_n (rst_n),
                   .q     (right_reg)
    );

    assign left_ack = right_reg;
    assign gate_en  = right_reg;

endmodule