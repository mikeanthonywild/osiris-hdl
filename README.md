# Osiris HDL [![Build Status](https://magnum.travis-ci.com/mikeanthonywild/osiris-hdl.svg?token=NDTyY9L4Xy88HazazqPp&branch=develop)](https://magnum.travis-ci.com/mikeanthonywild/osiris-hdl)

This repository contains all HDL code (sensor capture, data transfer and testbenches) for the Osiris camera project.

## Running

Two pre-built bitstreams are provided in the `bitfiles` directory, which can be loaded onto a pair of Zybo development boards using the Xilinx Vivado hardware manager and a USB JTAG cable. If these are not available, two .bin files are provided which can be loaded onto an SD card. To boot the Zybo from the SD card, rename the .bin file to BOOT.BIN, insert the SD card into the development board, change the boot jumper to SD, and power on the device.

The source code is contained within the `hdl` and `sw` directories, while the actual projects required to load the code onto the development boards are in the `project` directory, which is very large and must be downloaded separately from https://github.com/mikeanthonywild/osiris-hdl.

## Testing

Testbenches are written in Python using the MyHDL library, which interacts with Icarus Verilog to drive the compiled Verilog DUT. The Python tests are run using nose.

MyHDL must provide a *VPI* file for interaction with Icarus, so before any tests can be run you need to compile *myhdl.vpi* and copy it to the project root:

    $ git clone https://github.com/jandecaluwe/myhdl
    $ cd myhdl/cosimulation/icarus
    $ make
    $ cp myhdl.vpi PROJECT_ROOT

If testing on Linux, you will also need to install these pre-requisite packages before you can fetch the required Python packages: `libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev imagemagick`.

To run the tests, simply use:

    $ make test

This will compile the Verilog simulation binaries and run the Python tests so they can interact.

