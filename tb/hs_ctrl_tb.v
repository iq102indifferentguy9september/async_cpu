`timescale 1ns/1ps
module testbench;

    reg rst_n;
    reg left_reg;
    wire left_ack;
    reg right_ack;
    wire right_reg;
    wire gate_en;
    
    hs_ctrl uut (
        .rst_n    (rst_n),
        .left_reg (left_reg),
        .left_ack (left_ack),
        .right_ack(right_ack),
        .right_reg(right_reg),
        .gate_en  (gate_en)
    );
    
    initial begin
        left_reg = 0;
        
        @(posedge rst_n);
        #5;
        
        repeat (5) begin
            #10 left_reg = 1;
            @(posedge left_ack);
            #5  left_reg = 0;
            @(negedge left_ack);
        end
    end
    
    always @(posedge right_reg) begin
        #7 right_ack = 1;
    end
    
    always @(negedge right_reg) begin
        #4 right_ack = 0;
    end
    
    initial begin
        right_ack = 0;
        rst_n     = 0;
        #15 rst_n = 1;
        
        $monitor("Time=%0dns | rst_n=%b | L_REG=%b L_ACK=%b | R_REG=%b R_ACK=%b | GATE=%b", $time, rst_n, left_reg, left_ack, right_reg, right_ack, gate_en);
        
        #500;
        $display(">>> Over <<<");
        $finish;
    end

endmodule