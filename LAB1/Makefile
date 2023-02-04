all:vcs verdi
vcs:
	vcs \
	-f file_list \
	-timescale=1ns/1ns \
	-full64  -R  +vc  +v2k  -sverilog  -debug_access+all \
	|tee vcs.log 
verdi:
	verdi -sv -f file_list -ssf tb.fsdb &
clean:
	-rm -rf csrc  simv*  ucli.key   *.log  novas.*  verdiLog
	-rm -rf verilog.dump
	-rm -rf modelsim.ini transcript work
	-rm -rf *.fsdb*
	-rm -rf .inter.fsdb.tbsim


