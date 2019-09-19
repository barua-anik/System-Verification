class Ex6_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(Ex6_scoreboard)

  uvm_analysis_export #(Ex6_transaction) axp_in;
  uvm_analysis_export #(Ex6_transaction) axp_out;

  Ex6_predictor prd;
  Ex6_comparator cmp;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    axp_in = new("axp_in", this);
    axp_out = new("axp_out", this);

    prd = Ex6_predictor::type_id::create("prd", this);
    cmp = Ex6_comparator::type_id::create("cmp", this);
  endfunction

  function void connect_phase(uvm_phase phase);
   
    axp_in.connect (prd.analysis_export);
    axp_out.connect (cmp.axp_out);

    prd.results_ap.connect(cmp.axp_in);
  endfunction

endclass