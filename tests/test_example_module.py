import os

from myhdl import Cosimulation, Simulation, Signal, intbv


def test_example_module():
    clk = Signal(intbv(1))
    reset = Signal(intbv(0))
    d = Signal(intbv(0))
    dut = Cosimulation('vpp -m ./myhdl.vpi bin/example_module', 
                        clk=clk, 
                        reset=reset,
                        d=d)
    sim = Simulation(dut, None)
    sim.run()
    assert(1==1)

