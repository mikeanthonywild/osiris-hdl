import os

from myhdl import always, StopSimulation, Simulation, Cosimulation, Signal, instance, intbv, delay, traceSignals
from uhdl import Clock, Reset


def test_count_increments():
    """ Drives the clock and ensures that counter is working for full
    range of values.

    """

    # Signals and interface etc.
    clk = Clock()
    reset = Reset(async=True)
    count = Signal(intbv()[8:])

    def _bench():
        dut = Cosimulation('vvp -m ./myhdl.vpi ./bin/example_module/example_module', 
                           clk=clk, 
                           reset=reset,
                           count=count)

        @instance
        def stimulus():
            yield delay(255 * 2 + 4)
            print(count)
            assert count == 0xff
            raise StopSimulation

        return dut, clk.gen(), reset.pulse(), stimulus

    # = traceSignals(_bench)
    Simulation(_bench()).run()
