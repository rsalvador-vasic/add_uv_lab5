module dut_lab5 (
  input clk,
  input rst_n,
  input shutoff,
  output logic switch_en,
  output logic data_out
);


logic [7:0] b_counter_val;
logic [7:0] c_counter_val;
logic [7:0] d_counter_val;

logic b_clk;
logic c_clk;
logic d_clk;

logic b_clk_en;
logic c_clk_en;
logic d_clk_en;
logic c_rst_n;

logic isolate;
logic retain;
logic pg_rst_n;

always_comb c_rst_n = rst_n && pg_rst_n;  // Reset to u_c_counter_pg

/////////////////////////////////////////////////////////////////////////////////
//
//  Start of Lab4
//

// Remove and connect as per Lab5
always_comb b_clk = clk;
always_comb c_clk = clk;
always_comb d_clk = clk;
always_comb b_clk_en = 1'b1;
always_comb c_clk_en = 1'b1;
always_comb d_clk_en = 1'b1;
always_comb pg_rst_n = 1;















//  End of Lab 4
//
/////////////////////////////////////////////////////////////////////////////////



// Some logic combining counter outputs, so logic is not optimized away
always_comb data_out = b_counter_val & c_counter_val & d_counter_val;

////////////////////////////////////////
//
// Counter b_clk  - Always-On
//
////////////////////////////////////////

counter #(
  .CNT_VAL_W(8)
) u_b_counter (
 .clk        (b_clk),
 .rst_n      (rst_n),
 .en         (1'b1),
 .clear      (1'b0),

 .counter_val(b_counter_val)
);

////////////////////////////////////////
//
// Counter d_clk  - Always-On
//
////////////////////////////////////////


counter #(
  .CNT_VAL_W(8)
) u_d_counter (
 .clk        (d_clk),
 .rst_n      (rst_n),
 .en         (1'b1),
 .clear      (1'b0),

 .counter_val(d_counter_val)
);

////////////////////////////////////////
//
// Counter c_clk  - Power Gated
//
////////////////////////////////////////

counter #(
  .CNT_VAL_W(8)
) u_c_counter_pg (
 .clk        (c_clk),
 .rst_n      (c_rst_n),
 .en         (1'b1),
 .clear      (1'b0),

 .counter_val(c_counter_val)
);


endmodule
