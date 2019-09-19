class Ex6_sequence extends uvm_sequence #(Ex6_transaction);

  `uvm_object_utils(Ex6_sequence)

  Ex6_config _config;

  function new(string name="");
    super.new(name);
  endfunction: new

  task body();
    Ex6_transaction req;

    if(!uvm_config_db #(Ex6_config)::get(uvm_root::get(), "*", "Ex6_config", _config))
      `uvm_fatal("SEQUENCE", "Can't read config");

    uvm_test_done.raise_objection(this);
    repeat(_config.iterations)
    begin
      req = Ex6_transaction::type_id::create("req");
      start_item(req);

      if (_config.test_name == "test_zero") begin
	req.value1 = 0;
	req.value2 = 0;
	req.mode = DIV;
      end
      else if (_config.test_name == "test_lt_zero") begin
        req.value1 = 1;
	req.value2 = 2;
	req.mode = SUB;
      end
      else assert(req.randomize());

      finish_item(req);
    end
    uvm_test_done.drop_objection(this);
  endtask: body

endclass: Ex6_sequence