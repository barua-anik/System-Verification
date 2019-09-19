class Ex6_predictor extends uvm_subscriber #(Ex6_transaction);

  `uvm_component_utils(Ex6_predictor)

  Ex6_transaction out_txn;
  uvm_analysis_port #(Ex6_transaction) results_ap;

  covergroup transaction_coverage;
    cov_value1: coverpoint out_txn.value1 {
      bins zero = {0};
      bins f1to10 = {[1:9]};
      bins f10to100 = {[10:100]};
      bins rest = default;
    }
    cov_value2: coverpoint out_txn.value2 {
      bins zero = {0};
      bins f1to10 = {[1:9]};
      bins f10to100 = {[10:100]};
      bins rest = default;
    }
    mode_value: coverpoint out_txn.mode {
      bins add = {ADD};
      bins sub = {SUB};
      bins mul = {MUL};
      bins div = {DIV};
    }
  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    transaction_coverage = new;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    results_ap = new("results_ap", this);
  endfunction

  function void write (Ex6_transaction t);
    $cast(out_txn, t.clone());

    out_txn.correct = 1;

    case (t.mode)
      ADD: out_txn.result = t.value1 + t.value2;
      SUB: begin
	if (t.value2 > t.value1) begin
	  out_txn.correct = 0;
	end
 	out_txn.result = t.value1 - t.value2;
      end

      MUL: out_txn.result = t.value1 * t.value2;
      DIV: if (t.value2 == 0) begin
          out_txn.correct = 0;
          out_txn.result = 0;
        end
        else
          out_txn.result = t.value1 / t.value2;
    endcase

    transaction_coverage.sample();
    results_ap.write(out_txn);
  endfunction

  function void report_phase(uvm_phase phase);
    real pct;
    int unsigned covered;
    int unsigned total;


    pct = transaction_coverage.get_coverage(covered, total);
    $display("Coverage of Req: covered = %0d, total = %0d (%5.2f%%)", covered, total , pct);
    $display("Coverage of Instance %e", transaction_coverage.get_coverage());
  endfunction

endclass
