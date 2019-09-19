class Ex6_monitor extends uvm_monitor;

  `uvm_component_utils(Ex6_monitor)
 
  uvm_analysis_port #(Ex6_transaction) ap;

  Ex6_config m_config;

  virtual Ex6_interface m_vif;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap", this);

    if (!uvm_config_db #(Ex6_config)::get(this, "", "Ex6_config", m_config))
      `uvm_fatal("NOCONF",{"Config must be set for: ", get_full_name(), ".m_config"});
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    m_vif = m_config.vif; 
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    Ex6_transaction item;
    item = Ex6_transaction::type_id::create("item");

    forever @(posedge m_vif.clock) begin
       item.value1 = m_vif.value1;
       item.value2 = m_vif.value2;
       item.result = m_vif.result;
       item.correct = m_vif.correct;
       item.mode = m_vif.mode;
       ap.write(item);
    end

  endtask: run_phase

endclass: Ex6_monitor
