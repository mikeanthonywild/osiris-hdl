import re

from myhdl import *
from uhdl import *


def _tb_ov7670_init():
    # Signals and interface
    clk = Clock()
    reset_n = Reset()
    _continue = Signal(1)
    data = Signal(intbv(0)[16:])
    done = Signal(0)

    dut = Cosimulation('vvp -m ./myhdl.vpi ./bin/ov7670/ov7670_init', 
                           clk=clk, reset_n=reset_n, _continue=_continue,
                           data=data, done=done)

    return clk, reset_n, _continue, data, done, dut

def parse_register_values():
    """ Opens up ov7670_init.v and parses correct register values.

    """
    regs = []
    p = re.compile(r"^\s*(?P<step>\d+)\s+: data <= 'h(?P<addr>[0-9,a-f]{2})(?P<value>[0-9,a-f]{2}).*$")

    with open('hdl/ov7670/ov7670_init.v') as f:

        for line in f:
            # Skip until we find first register value
            m = p.match(line)
            if m is not None:
                regs.append(m.groupdict())

            # Found our last line
            if 'default:' in line:
                break

    return regs


def test_ov7670_init_register_values():
    """ Test that the data output contains correct sequence of register
    addresses and values.

    """
    clk, reset_n, _continue, data, done, dut = _tb_ov7670_init()

    def _bench():
        # Parse values from the actual source file
        regs = parse_register_values()

        @instance
        def stimulus():
            yield reset_n.posedge

            for reg in regs:
                yield clk.posedge

                got = hex(data)[2:].zfill(4)
                expected = reg['addr'] + reg['value']

                try:
                    assert got == expected
                except AssertionError:
                    print("Register mismatch [Step {}]. Data={}, should be {}.".format(
                          reg['step'], got, expected))
                    raise AssertionError

            raise StopSimulation

        return dut, clk.gen(), reset_n.pulse(), stimulus

    Simulation(_bench()).run()

def test_ov7670_init_assert_done_after_finished():
    """ Test that 'done' gets asserted after initialisation has
    finished.

    """
    clk, reset_n, _continue, data, done, dut = _tb_ov7670_init()

    def _bench():
        @instance
        def stimulus():
            yield reset_n.posedge

            count = 0
            while data != 0xffff:
                yield clk.posedge
                if count > 100:
                    print("Test timed out")
                    raise Exception
                count = count + 1

            assert done
            raise StopSimulation

        return dut, clk.gen(), reset_n.pulse(), stimulus

    Simulation(_bench()).run()
