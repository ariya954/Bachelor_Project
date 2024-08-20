// **************************************************************************************
// Filename: Register.v
// Project: Debugger Module
// Version: 1.0
// Date:
//
// Module Name: register
// Description:
//
// Dependencies:
//
// File content description:
// Register for Debugger Module
//
// **************************************************************************************
`timescale 1ns/1ns

module register #( parameter size = 32) (
    input [size-1:0] in,
    input ldR,
    input clk,
    input rst,
    output [size-1:0] out
);

    reg [size-1:0] Rreg;
    assign out = Rreg;

    always @ (posedge clk, posedge rst) begin: RREG
        if(rst)
            Rreg = {(size){1'b0}};
        else if(ldR)
            Rreg = in;
    end

endmodule
