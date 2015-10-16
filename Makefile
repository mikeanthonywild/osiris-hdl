VC			:= iverilog
CFLAGS 		:=

BINDIR 		:= bin
SOURCEDIR 	:= hdl

SOURCES 	:= $(shell find $(SOURCEDIR) -name '*_dut.v')

test: sim_compile nosetests

sim_compile:
	mkdir -p $(BINDIR)
	@$(foreach sourcefile, $(SOURCES), @echo $(sourcefile))

nosetests:
	nosetests

clean:
	rm -rf $(BINDIR)

all: clean test