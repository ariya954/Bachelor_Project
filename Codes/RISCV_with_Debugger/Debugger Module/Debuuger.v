// **************************************************************************************
// Filename: Debugger.v
// Project: AFTAB
// Version: 1.0
// Date:
//
// Module Name: Debugger
// Description:
//
// Dependencies:
//
// File content description:
// Debugger for AFTAB
//
// **************************************************************************************
`timescale 1ns/1ns

module Debugger #(parameter size = 32) (
    input clk,
    input rst,
    input debug_request,
    input core_reset_request, core_halt_request, core_busy,
    input  [size-1:0] debug_instruction,
    inout  [size-1:0] debugger_port,
    output [size-1:0] debugger_result,
    output debugger_busy, core_reset, core_halt
);

    wire load_debug_result,
         load_debug_command, 
         load_debug_command_data_argument,
         load_debug_command_address_argument, 
         send_debug_command,
         send_debug_command_data_argument, 
         send_debug_command_address_argument;

    DataPath #(size) DP (
        .clk(clk),
        .rst(rst),
        .core_reset_request(core_reset_request),
        .core_halt_request(core_halt_request), 
        .load_debug_result(load_debug_result),
        .load_debug_command(load_debug_command), 
        .load_debug_command_data_argument(load_debug_command_data_argument),
        .load_debug_command_address_argument(load_debug_command_address_argument), 
        .send_debug_command(send_debug_command),
        .send_debug_command_data_argument(send_debug_command_data_argument), 
        .send_debug_command_address_argument(send_debug_command_address_argument),
        .core_reset(core_reset),
        .core_halt(core_halt),
        .debug_instruction(debug_instruction),
        .debugger_port(debugger_port),
        .debugger_result(debugger_result)
    );

    Controller CU (
        .clk(clk),
        .rst(rst),
        .debug_request(debug_request), 
        .core_busy(core_busy),
        .load_debug_result(load_debug_result),
        .load_debug_command(load_debug_command), 
        .load_debug_command_data_argument(load_debug_command_data_argument),
        .load_debug_command_address_argument(load_debug_command_address_argument), 
        .send_debug_command(send_debug_command),
        .send_debug_command_data_argument(send_debug_command_data_argument), 
        .send_debug_command_address_argument(send_debug_command_address_argument),
        .debugger_busy(debugger_busy)
    );

endmodule