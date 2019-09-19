class Ex6_test_lt_zero extends uvm_test;
  `uvm_component_utils(Ex6_test_lt_zero)
  Ex6_env m_env;
  Ex6_config m_config;
  Ex6_sequence _sequence;
  Ex6_agent_config _agent_config;

  function new(string name = "Ex6_test_lt_zero", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void set_config_params();
    m_config = Ex6_config::type_id::create("m_config");
    _agent_config = Ex6_agent_config::type_id::create("agent_config");

    if(!uvm_config_db #(virtual Ex6_interface)::get(this, "uvm_test_top", "top_interface", m_config.vif))
      `uvm_fatal("Ex6 TEST", "Can't read VIF");

    if(!uvm_config_db #(virtual Ex6_interface)::get(this, "uvm_test_top", "top_interface", _agent_config.vif))
      `uvm_fatal("Ex6 TEST", "Can't read VIF");

    m_config.test_name = "test_lt_zero";
    _agent_config.active = UVM_ACTIVE;

    uvm_config_db #(Ex6_config)::set(uvm_root::get(), "*", "Ex6_config", m_config);
    uvm_config_db #(Ex6_agent_config)::set(this, "*", "Ex6_agent_config", _agent_config);
  endfunction;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    set_config_params();

    m_env = Ex6_env::type_id::create("m_env", this);
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    _sequence = Ex6_sequence::type_id::create("_sequence");
    phase.raise_objection(this);
      _sequence.start(m_env._sequencer);
    phase.drop_objection(this);

  endtask: run_phase

endclass