module top;

  import uvm_pkg::*;
  import Ex6_pkg::*;

  Ex6_interface _interface();
  Ex6_dut dut(_interface.dut_mp);
  Ex6_clock_driver clk(_interface.clock_driver_mp);
  Ex6_env env;

  initial begin
    uvm_config_db #(virtual Ex6_interface)::set(null, "*", "top_interface", _interface);
    run_test();
  end

endmodule: top
