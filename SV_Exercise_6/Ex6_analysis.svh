class Ex6_analysis extends uvm_component;

  `uvm_component_utils(Ex6_analysis)

  uvm_analysis_export #(Ex6_transaction) _export;
  uvm_analysis_export #(Ex6_transaction) _import;

  uvm_tlm_analysis_fifo #(Ex6_transaction) _fifo_in;
  uvm_tlm_analysis_fifo #(Ex6_transaction) _fifo_out;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    _export = new("_export", this);
    _fifo_in = new("_fifo_in", this);

    _import = new("_import", this);
    _fifo_out = new("_fifo_out", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    _export.connect(_fifo_in.analysis_export);
    _import.connect(_fifo_out.analysis_export);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    Ex6_transaction item;

    forever begin
      _fifo_in.get(item);

      _fifo_out.get(item);

    end
  endtask

endclass: Ex6_analysis
