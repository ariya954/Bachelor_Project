// **************************************************************************************
// Filename: Tristate.v
// Project: Debugger Module
// Version: 1.0
// Date:
//
// Module Name: tristate
// Description:
//
// Dependencies:
//
// File content description:
// Tristate for Debugger Module
//
// **************************************************************************************
`timescale 1ns/1ns

module tristate #(parameter size = 32)(
    input  [size-1:0] in,
    output [size-1:0] out,
    input enable
);

    assign out = (enable) ? in : {(size){1'bz}};

endmodule