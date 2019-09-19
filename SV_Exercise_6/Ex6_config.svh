class Ex6_config extends uvm_object;
  `uvm_object_utils(Ex6_config);


  virtual Ex6_interface vif;

  int iterations = 3;
  string test_name = "test";

  function new(string name = "");
    super.new(name);
  endfunction

endclass