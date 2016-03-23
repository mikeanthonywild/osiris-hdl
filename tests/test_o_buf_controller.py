import struct

from myhdl import *
from uhdl import *
from PIL import Image


image_data = Image.open('tests/images/vga_test_pattern.bmp').convert('L')
image_pixels = image_data.load()

def _tb_o_buf_controller():
    # Signals and interfaces etc.
    pclk = Clock()
    reset_n = Reset()
    i_data = Signal(intbv(0)[32:])
    vsync = Signal(1)
    hsync = Signal(0)
    vde = Signal(0)
    addr = Signal(intbv(0)[32:])
    o_data = Signal(intbv(0)[8:0])
    req_line = Signal(0)
    req_frame = Signal(0)

    dut = Cosimulation('vvp -m ./myhdl.vpi ./bin/o_buf_controller/o_buf_controller',
                        pclk=pclk, reset_n=reset_n, i_data=i_data,
                        vsync=vsync, hsync=hsync, vde=vde, 
                        addr=addr, o_data=o_data, req_line=req_line, 
                        req_frame=req_frame)

    return (pclk, reset_n, i_data, vsync, hsync, vde,  
        addr, o_data, req_line, req_frame, dut)

def test_video_output_from_linebuffer():
    """ Test that we can display a line fetched from the linebuffer.

    """
    capture_data = Image.new('L', (image_data.size[0], 1))
    capture_pixels = capture_data.load()

    (pclk, reset_n, i_data, vsync, hsync, vde,  
        addr, o_data, req_line, req_frame, dut) = _tb_o_buf_controller()

    def _bench():
        @instance
        def stimulus():
            yield reset_n.posedge
            yield pclk.posedge

            # Wait a two clock periods for output to propagate
            yield delay(2 * pclk.period)

            for pixel in range(800):
                if pixel < 640:
                    capture_pixels[pixel, 0] = int(o_data)
                yield pclk.posedge

            capture_data.save('tests/output/test_video_output_from_linebuffer.bmp')

            # Check captured data
            for pixel in range(640):
                print(capture_pixels[pixel, 0], image_pixels[pixel, 0])
                try:
                    assert capture_pixels[pixel, 0] == image_pixels[pixel, 0]
                except AssertionError:
                    print("Pixel mismatch [{}]. Captured {}, should be {}".format(
                          pixel, capture_pixels[pixel, 0], image_pixels[pixel, 0]))
                    raise AssertionError

            raise StopSimulation

        @always(pclk.posedge)
        def linebuffer_read():
            offset = int(addr) * 4
            pixels = 0
            for i in range(4):
                pixels = pixels | image_pixels[offset+i, 0] << ((3-i) * 8)
                
            i_data.next = pixels

        return dut, pclk.gen(), reset_n.pulse(), stimulus, linebuffer_read
        
    Simulation(_bench()).run()


def test_linebuffer_addr_resets_after_new_line():
    """ Test that the linebuffer address is reset after we start a new
    line.

    """
    (pclk, reset_n, i_data, vsync, hsync, vde,  
        addr, o_data, req_line, req_frame, dut) = _tb_o_buf_controller()

    def _bench():
        @instance
        def stimulus():
            yield reset_n.posedge
            yield pclk.posedge

            # Let the DUT clock out a line
            for pixel in range(800):
                yield pclk.posedge

            yield pclk.posedge

            assert addr == 0x00
            raise StopSimulation

        return dut, pclk.gen(), reset_n.pulse(), stimulus

    Simulation(_bench()).run()


def test_linebuffer_ps_interrupts():
    """ Test that the Processing System receives the correct
    interrupts so we can request new data.

    """
    (pclk, reset_n, i_data, vsync, hsync, vde,  
        addr, o_data, req_line, req_frame, dut) = _tb_o_buf_controller()

    def _bench():
        @instance
        def stimulus():
            yield reset_n.posedge
            yield pclk.posedge

            

            # Start wait some cycles to simulate data being stored
            # in linebuffer.
            for line in range(525):
                for pixel in range(800):
                    # req_line should pulse as soon as we have finished the line
                    if pixel >= 640 and line < 480:
                        assert req_line
                    # req_frame is asserted briefly during the last line before blankingo
                    if line == 479 and pixel:
                        assert req_frame
                    yield pclk.posedge

            raise StopSimulation

        return dut, pclk.gen(), reset_n.pulse(), stimulus
        
    Simulation(_bench()).run()