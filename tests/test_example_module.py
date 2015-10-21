import os

from myhdl import Cosimulation, Simulation, Signal, intbv
from myhdl import delay, always, now, instance, always_comb, bin


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

# Testing out some MyHDL features
def HelloWorld(clk, to='World'):
    @always(clk.posedge)
    def say_hello():
        print("Hello, {}! Timestep: {}".format(to, now()))

    return say_hello

def ClkDriver(clk, period=20):
    half_period = int(period / 2)

    @instance
    def drive_clk():
        while True:
            yield delay(half_period)
            clk.next = not clk

    return drive_clk

def Greetings():
    clk1 = Signal(0)
    clk2 = Signal(0)

    driver1 = ClkDriver(clk1)
    driver2 = ClkDriver(clk2, period=6)

    hello1 = HelloWorld(clk1)
    hello2 = HelloWorld(clk2, to='MyHDL')

    return driver1, driver2, hello1, hello2

def Bin2Gray(B, G, width):
    """ Gray encoder

    B -- input intbv signal, binary encoded
    G -- output intbv signal, gray encoded
    width -- bit width
    """

    @always_comb
    def logic():
        for i in range(width):
            G.next[i] = B[i+1] ^ B[i]

    return logic

def TestBench(width):
    B = Signal(intbv(0))
    G = Signal(intbv(0))

    dut = Bin2Gray(B, G, width)

    @instance
    def stimulus():
        for i in range(2**width):
            B.next = intbv(i)
            yield delay(10)
            print("B: {}| G: {}".format(bin(B, width), bin(G, width)))

    return dut, stimulus


if __name__ == '__main__':
    sim = Simulation(TestBench(3

        ))
    sim.run()

