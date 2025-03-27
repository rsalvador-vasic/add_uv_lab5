`timescale 1ns/100ps

module tb_lab5 ();

// Define Parameters and Logics

localparam sim_time = 2000; // Simulation time in ns

localparam clk_per = 10.0;

logic       status;
logic       clk;
logic       shutoff;
logic       poweron_rst_n;    // Power-On Reset, from voltage monitor
logic [7:0] counter_val;
logic       switch_en;


// Generate free-running clock sources

initial begin
    clk = 1'b0;
    forever 
      clk = #(clk_per/2) !clk;
end



// Release Power-On reset before clock sources toggle

initial begin
  shutoff       = 1'b0;
  poweron_rst_n = 1'b0;
  #5ns;
  poweron_rst_n = 1'b1;

  repeat (20) @ (posedge clk);
  #1ns;
  shutoff = 1'b0;

  repeat (20) @ (posedge clk);
  #1ns;
  shutoff = 1'b1;

  repeat (20) @ (posedge clk);
  #1ns;
  shutoff = 1'b0;

  repeat (20) @ (posedge clk);
  #1ns;
  shutoff = 1'b1;

  repeat (20) @ (posedge clk);
  #1ns;
  shutoff = 1'b0;

  repeat (20) @ (posedge clk);
  #1ns;
  shutoff = 1'b1;

  repeat (20) @ (posedge clk);
  #1ns;
  shutoff = 1'b0;

  repeat (20) @ (posedge clk);
  #1ns;
  shutoff = 1'b1;

  repeat (20) @ (posedge clk);
  #1ns;
  shutoff = 1'b0;
  

end

`ifdef LP_SIM

initial
  begin

    status = $supply_on("dut_lab5.DGND",           0);
    status = $supply_on("dut_lab5.DVDD_CORE",    0.9);
    status = $supply_on("dut_lab5.DVDD_COREPG", 0.9);
  end


always @(*)
  begin
    if(switch_en)
      status = $supply_on ("dut_lab5.DVDD_COREPG", 0.9);
    else
      begin
        #5ns;
        status = $supply_off("dut_lab5.DVDD_COREPG");
      end  
  end

`endif

// Dump waveforms and stop simulation
initial begin
    $shm_open(,1);
    $shm_probe("ACTM");
    #(sim_time);
    $finish();
end


// Instantiate DUT

dut_lab5 dut_lab5(
  // Inputs
  .clk         (clk),
  .rst_n       (poweron_rst_n),
  .shutoff     (shutoff),

  // Outputs
  .switch_en(switch_en),
  .data_out ()
);



endmodule
