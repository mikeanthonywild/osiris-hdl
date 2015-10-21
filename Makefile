VC			:= iverilog
CFLAGS 		:=

BINDIR 		:= bin
SOURCEDIR 	:= hdl

DUT_FILES 	:= $(shell find $(SOURCEDIR) -name '*_dut.v')

test: icarus nosetests

icarus: $(patsubst $(SOURCEDIR)/%_dut.v, $(BINDIR)/%, $(DUT_FILES)) 

$(BINDIR)/%: $(SOURCEDIR)/%.v $(SOURCEDIR)/%_dut.v
	mkdir -p $(@D)
	$(VC) -o $@ $^

nosetests:
	nosetests

clean:
	rm -rf $(BINDIR)

all: clean test
