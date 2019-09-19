interface Ex6_interface;

  import types_pkg::*;

  logic clock;
  logic reset;

  shortint unsigned value1, value2, correct;
  int unsigned result;
  op_type mode;

  modport dut_mp(
    input clock,
    input reset,
    input value1,
    input value2,
    input mode,
    output result,
    output correct
  );

  modport clock_driver_mp(
    output clock,
    output reset
  );
endinterface: Ex6_interface
