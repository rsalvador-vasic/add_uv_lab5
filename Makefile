sim:
	xrun -sv \
	-f tb_lab5.f \
	-access +rwc

sim_upf:
	xrun -sv \
	-f tb_lab5.f \
	-access +rwc \
        +define+LP_SIM \
	-logfile xmelab.log \
	-lps_dut_top tb_lab5 \
	-lps_1801 lab5_sim_wrapper.upf \
	-lps_verbose 3 \
	-lps_logfile lps.log \
	-lps_dbc


