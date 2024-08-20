// **************************************************************************************
// Filename: Controller.v
// Project: Debugger Module
// Version: 1.0
// Date:
//
// Module Name: Controller
// Description:
//
// Dependencies:
//
// File content description:
// Controller for Debugger Module
//
// **************************************************************************************
`timescale 1ns/1ns

module Controller (
    input clk, rst, debug_request, core_busy,
    output reg load_debug_result, load_debug_command, load_debug_command_data_argument, load_debug_command_address_argument, send_debug_command, send_debug_command_data_argument, send_debug_command_address_argument,
    output reg debugger_busy
);

    reg[2 : 0] ns, ps;
    parameter[2 : 0] waiting_for_debug_request = 3'b000, sending_debug_command_to_core = 3'b001, sending_debug_command_data_argument_to_core = 3'b010, sending_debug_command_address_argument_to_core = 3'b011, waiting_for_core_respond = 3'b100;
    always @(ps, debug_request, core_busy) begin
       {load_debug_result, load_debug_command, load_debug_command_data_argument, load_debug_command_address_argument, send_debug_command, send_debug_command_data_argument, send_debug_command_address_argument} = 7'b0;
       case(ps) 
           waiting_for_debug_request:  begin ns = debug_request ? sending_debug_command_to_core : waiting_for_debug_request; load_debug_command = debug_request; debugger_busy = 0; end
           sending_debug_command_to_core:  begin ns = sending_debug_command_data_argument_to_core; send_debug_command = 1; load_debug_command_data_argument = 1; end
           sending_debug_command_data_argument_to_core:  begin ns = sending_debug_command_address_argument_to_core; send_debug_command_data_argument = 1; load_debug_command_address_argument = 1; end
           sending_debug_command_address_argument_to_core:  begin ns = waiting_for_core_respond; send_debug_command_address_argument = 1; debugger_busy = 1; end          
	   waiting_for_core_respond: begin ns = core_busy ? waiting_for_core_respond : waiting_for_debug_request;  load_debug_result = ~core_busy; end
           default: ns = waiting_for_debug_request;
       endcase
    end

    always @(posedge clk, posedge rst) begin
      if(rst)
        ps <= waiting_for_debug_request;
      else
        ps <= ns;
    end

endmodule