from myhdl import *
from uhdl import *
from PIL import Image


image_data = Image.open('tests/images/qcif_test_pattern.bmp').convert('L')
image_pixels = image_data.load()

def _tb_ov7670_capture():
    # Signals and interface etc.
    pclk_24 = Clock()
    reset_n = Reset(async=True)
    start = Signal(0)
    vsync = Signal(1)
    href = Signal(0)
    d = Signal(intbv(0)[8:])
    addr = Signal(intbv()[16:])
    dout = Signal(intbv()[8:])

    dut = Cosimulation('vvp -m ./myhdl.vpi ./bin/ov7670/ov7670_capture', 
                           pclk_24=pclk_24, reset_n=reset_n, start=start, 
                           vsync=vsync, href=href, d=d,
                           addr=addr, dout=dout)

    return pclk_24, reset_n, start, vsync, href, d, addr, dout, dut

def test_ov7670_capture():
    """ Test whether we can correctly capture a frame. """
    capture_data = Image.new('L', image_data.size)
    capture_pixels = capture_data.load()

    pclk_24, reset_n, start, vsync, href, d, addr, dout, dut = _tb_ov7670_capture()

    def _bench():
        T_P = pclk_24.period
        T_LINE = 784 * T_P

        @instance
        def stimulus():
            yield pclk_24.posedge
            start.next = 1
            yield delay(3 * T_LINE)

            # New frame
            vsync.next = 0
            yield delay(17 * T_LINE)

            # Timing digram from datasheet
            # FIXME: Why the fuck does this take so long to simulate?
            for y in range(image_data.size[1]):
                href.next = 1 
                for x in range(image_data.size[0]):
                    d.next = image_pixels[x, y]
                    yield pclk_24.posedge

                # End of line
                href.next = 0
                yield delay(144 * T_P)

            # End of frame
            vsync.next = 1
            start.next = 0
            yield pclk_24.posedge

            # Check that test image and captured image match
            for y in range(image_data.size[1]):
                for x in range(image_data.size[0]):
                    try:
                        assert capture_pixels[x, y] == image_pixels[x, y]
                    except AssertionError:
                        print("Pixel mismatch [{}, {}]. Captured {}, should be {}".format(
                              x, y, capture_pixels[x, y], image_pixels[x, y]))
                        raise AssertionError

            raise StopSimulation

        @always(pclk_24.posedge)
        def check_framebuffer():
            if (start):
                x = int(addr) % image_data.size[0]
                y = int(addr) / image_data.size[0]
                capture_pixels[x, y] = int(dout)

        return dut, pclk_24.gen(), reset_n.pulse(), stimulus, check_framebuffer
        
    Simulation(_bench()).run()


def test_ov7670_addr_resets_after_new_frame():
    """ Test that the framebuffer address is reset after we start a new
    frame.

    """
    pclk_24, reset_n, start, vsync, href, d, addr, dout, dut = _tb_ov7670_capture()

    def _bench():
        T_P = pclk_24.period
        T_LINE = 784 * T_P

        @instance
        def stimulus():
            yield pclk_24.posedge
            start.next = 1
            yield pclk_24.posedge

            # Start new frame and new line, wait 4 clock periods for
            # address to increment.
            vsync.next = 0
            yield pclk_24.posedge
            href.next = 1
            yield delay(T_P * 4)

            # End this frame and wait two clocks for addr to propagate
            href.next = 0
            vsync.next = 1
            yield delay(T_P * 2)

            assert addr == 0x00
            raise StopSimulation

        return dut, pclk_24.gen(), reset_n.pulse(), stimulus

    Simulation(_bench()).run()