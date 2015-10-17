# Osiris HDL [![Build Status](https://magnum.travis-ci.com/mikeanthonywild/osiris-hdl.svg?token=NDTyY9L4Xy88HazazqPp&branch=develop)](https://magnum.travis-ci.com/mikeanthonywild/osiris-hdl)

This repository contains all HDL code (sensor capture, data transfer and testbenches) for the Osiris project.

## Testing

Testbenches are written in Python using the MyHDL library, which interacts with Icarus Verilog to drive the compiled Verilog DUT. The Python tests are run using nose.

To run the tests, simply use:

    $ make test

This will compile the simulation Verilog simulation binaries and run the Python tests so they can interact.

