# Osiris HDL [![Build Status](https://magnum.travis-ci.com/mikeanthonywild/osiris-hdl.svg?token=NDTyY9L4Xy88HazazqPp&branch=develop)](https://magnum.travis-ci.com/mikeanthonywild/osiris-hdl)

This repository contains all HDL code (sensor capture, data transfer and testbenches) for the Osiris camera project.

## Testing

Testbenches are written in Python using the MyHDL library, which interacts with Icarus Verilog to drive the compiled Verilog DUT. The Python tests are run using nose.

MyHDL must provide a *VPI* file for interaction with Icarus, so before any tests can be run you need to compile *myhdl.vpi* and copy it to the project root:

    $ git clone https://github.com/jandecaluwe/myhdl
    $ cd myhdl/cosimulation/icarus
    $ make
    $ cp myhdl.vpi PROJECT_ROOT

To run the tests, simply use:

    $ make test

This will compile the Verilog simulation binaries and run the Python tests so they can interact.

