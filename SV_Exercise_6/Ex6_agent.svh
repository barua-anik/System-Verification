class Ex6_agent extends uvm_component;

  `uvm_component_utils(Ex6_agent)

  Ex6_agent_config m_cfg;


  uvm_analysis_port #(Ex6_transaction) input_analysis_port;
  uvm_analysis_port #(Ex6_transaction) output_analysis_port;

  Ex6_monitor m_monitor;
  Ex6_sequencer m_sequencer;
  Ex6_driver m_driver;

  function new(string name = "Ex6_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(Ex6_agent_config)::get(this, "", "Ex6_agent_config", m_cfg))
      `uvm_fatal("CONFIC_LOAD", "Cannot get() configuration Ex6_agent_config from uvm_config_db!")

    m_monitor = Ex6_monitor::type_id::create("m_monitor", this);

    if (m_cfg.active == UVM_ACTIVE) begin
      m_driver = Ex6_driver::type_id::create("m_driver", this);
      m_sequencer = Ex6_sequencer::type_id::create("m_sequencer", this);
    end

  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    output_analysis_port = m_monitor.ap;
    input_analysis_port = m_driver.ap;

    if (m_cfg.active == UVM_ACTIVE) begin
      m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    end
  endfunction: connect_phase

endclass: Ex6_agent
