all:vcs verdi
vcs:
	vcs \
	-f run.f \
	-timescale=1ns/1ns \
	-full64  -R  +vc  +v2k  -sverilog  -debug_access+all \
	|tee vcs.log 
dve:
	./sim -gui
verdi:
	verdi -sv -f run.f -ssf tb.fsdb &
clean:
	-rm -rf csrc  simv*  ucli.key   *.log  novas.*  verdiLog
	-rm -rf verilog.dump
	-rm -rf modelsim.ini transcript work
	-rm -rf *.fsdb*
	-rm -rf .inter.fsdb.tbsim
	-rm -rf DVEfiles
	-rm -rf inter.vpd
	-rm -rf .restartSimSession.tcl.old


