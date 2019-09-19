class Ex6_agent_config extends uvm_object;

  `uvm_object_utils(Ex6_agent_config)

  virtual Ex6_interface vif;

  uvm_active_passive_enum active = UVM_ACTIVE;

  function new(string name = "Ex6_agent_config");
   super.new(name);
  endfunction

endclass: Ex6_agent_config