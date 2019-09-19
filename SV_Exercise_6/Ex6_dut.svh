module Ex6_dut(Ex6_interface.dut_mp dut_interface);

  typedef enum {ADD, SUB, MUL, DIV} op_type;

  always @(posedge dut_interface.clock or negedge dut_interface.reset)

  begin
    dut_interface.correct = 1;
    if (dut_interface.reset)
    	dut_interface.result = 0;
    else begin
      if (dut_interface.value2 == 0 && dut_interface.mode == DIV) begin
        dut_interface.result = 0;
        dut_interface.correct = 0;
      end

      else 
	    case(dut_interface.mode)
	    	ADD: dut_interface.result = dut_interface.value1 + dut_interface.value2;
	    	SUB: begin
			dut_interface.result = dut_interface.value1 - dut_interface.value2;
			if (dut_interface.value2 > dut_interface.value1) dut_interface.correct = 0;
		end
	    	MUL: dut_interface.result = dut_interface.value1 * dut_interface.value2;
	    	DIV: dut_interface.result = dut_interface.value1 / dut_interface.value2;
	    endcase
    end
  end

endmodule: Ex6_dut
