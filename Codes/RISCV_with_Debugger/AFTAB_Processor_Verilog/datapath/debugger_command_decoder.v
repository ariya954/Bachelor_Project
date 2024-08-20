// **************************************************************************************
// Filename: debugger_command_decoder.v
// Project: AFTAB
// Version: 1.0
// Date:
//
// Module Name: debugger_command_decoder
// Description:
//
// Dependencies:
//
// File content description:
// Debugger Command Decoder for AFTAB datapath
//
// **************************************************************************************
`timescale 1ns/1ns

module debugger_command_decoder #(parameter size = 32) (
    input clk,
    input rst,
    input [size-1:0] debugger_port,
    input load_debugger_command,
    input load_debugger_command_data_argument,
    input load_debugger_command_address_argument,
    output read_register_request_from_debugger,
    output write_register_request_from_debugger,
    output read_memory_request_from_debugger,
    output write_memory_request_from_debugger,
    output [4:0] given_register_number_from_debugger,
    output [size-1:0] given_data_argument_from_debugger,
    output [size-1:0] given_address_argument_from_debugger
);

    wire [size-1:0] debugger_command, debugger_command_data_argument, debugger_command_address_argument;

    aftab_register #(size) Debugger_Command_Register (
        .clk(clk),
        .rst(rst),
        .zero(0),
        .ldR(load_debugger_command),
        .in(debugger_port),
        .out(debugger_command)
    );

    aftab_register #(size) Debugger_Command_Data_Argument_Register (
        .clk(clk),
        .rst(rst),
        .zero(0),
        .ldR(load_debugger_command_data_argument),
        .in(debugger_port),
        .out(debugger_command_data_argument)
    );

    aftab_register #(size) Debugger_Command_Address_Argument_Register (
        .clk(clk),
        .rst(rst),
        .zero(0),
        .ldR(load_debugger_command_address_argument),
        .in(debugger_port),
        .out(debugger_command_address_argument)
    );    

    assign read_register_request_from_debugger = ~debugger_command[16] & debugger_command[17];
    assign write_register_request_from_debugger = debugger_command[16] & debugger_command[17];
    assign read_memory_request_from_debugger = ~debugger_command[16] & debugger_command[25];
    assign write_memory_request_from_debugger = debugger_command[16] & debugger_command[25];
    assign given_register_number_from_debugger = debugger_command[4:0];
    assign given_data_argument_from_debugger = debugger_command_data_argument;
    assign given_address_argument_from_debugger = debugger_command_address_argument;

endmodule