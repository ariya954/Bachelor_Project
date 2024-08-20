// **************************************************************************************
// Filename: DataPath.v
// Project: Debugger Module
// Version: 1.0
// Date:
//
// Module Name: DataPath
// Description:
//
// Dependencies:
//
// File content description:
// DP for Debugger Module
//
// **************************************************************************************
`timescale 1ns/1ns

module DataPath #(parameter size = 32)(
    input clk, rst, core_reset_request, core_halt_request, load_debug_result, load_debug_command, load_debug_command_data_argument, load_debug_command_address_argument, send_debug_command, send_debug_command_data_argument, send_debug_command_address_argument,
    output core_reset, core_halt,
    input  [size-1:0] debug_instruction,
    inout  [size-1:0] debugger_port,
    output [size-1:0] debugger_result
);

    wire [size-1:0] debugger_command, debugger_command_data_argument, debugger_command_address_argument;

    assign core_reset = core_reset_request;
    assign core_halt = core_halt_request;

    register #(size) Debugger_Command_Register (
        .clk(clk),
        .rst(rst),
        .ldR(load_debug_command),
        .in(debug_instruction),
        .out(debugger_command)
    );

    register #(size) Debugger_Command_Data_Argument_Register (
        .clk(clk),
        .rst(rst),
        .ldR(load_debug_command_data_argument),
        .in(debug_instruction),
        .out(debugger_command_data_argument)
    );

    register #(size) Debugger_Command_Address_Argument_Register (
        .clk(clk),
        .rst(rst),
        .ldR(load_debug_command_address_argument),
        .in(debug_instruction),
        .out(debugger_command_address_argument)
    );

    register #(size) Debugger_Result_Register (
        .clk(clk),
        .rst(rst),
        .ldR(load_debug_result),
        .in(debugger_port),
        .out(debugger_result)
    );

    tristate #(size) Debuuger_Command_Tristate (
        .in(debugger_command),
        .enable(send_debug_command),
        .out(debugger_port)        
    ); 

    tristate #(size) Debuuger_Command_Data_Argument_Tristate (
        .in(debugger_command_data_argument),
        .enable(send_debug_command_data_argument),
        .out(debugger_port)        
    ); 

    tristate #(size) Debuuger_Command_Address_Argument_Tristate (
        .in(debugger_command_address_argument),
        .enable(send_debug_command_address_argument),
        .out(debugger_port)        
    ); 

endmodule