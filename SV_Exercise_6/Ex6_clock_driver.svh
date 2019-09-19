module Ex6_clock_driver(Ex6_interface.clock_driver_mp clock_interface);

  initial begin
    clock_interface.reset <= 0;
    clock_interface.clock <= 0;
  end

  always begin
    forever #10 clock_interface.clock = ~clock_interface.clock;
  end

endmodule: Ex6_clock_driver
