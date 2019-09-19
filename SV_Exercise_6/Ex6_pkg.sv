package Ex6_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import types_pkg::*;
  `include "Ex6_config.svh"
  `include "Ex6_agent_config.svh"

  `include "Ex6_transaction.svh"
  `include "Ex6_sequence.svh"

  typedef uvm_sequencer #( Ex6_transaction ) Ex6_sequencer;

  `include "Ex6_driver.svh"
  `include "Ex6_monitor.svh"
  `include "Ex6_agent.svh"
  `include "Ex6_analysis.svh"
  `include "Ex6_predictor.svh"
  `include "Ex6_comparator.svh"
  `include "Ex6_scoreboard.svh"
  `include "Ex6_env.svh"
  `include "Ex6_test.svh"
  `include "Ex6_test_zero.svh"
  `include "Ex6_test_lt_zero.svh"

endpackage: Ex6_pkg