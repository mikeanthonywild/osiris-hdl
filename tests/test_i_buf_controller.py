import struct

from myhdl import *
from uhdl import *
from PIL import Image


image_data = Image.open('tests/images/qvga_test_pattern.bmp').convert('L')
image_pixels = image_data.load()

def _tb_i_buf_controller():
    # Signals and interfaces etc.
    pclk = Clock()
    reset_n = Reset()
    vsync = Signal(1)
    hsync = Signal(0)
    vde = Signal(0)
    i_data = Signal(intbv(0)[8:])
    we = Signal(0)
    addr = Signal(intbv(0)[32:])
    o_data = Signal(intbv(0)[32:0])
    line_valid = Signal(0)
    frame_valid = Signal(0)

    dut = Cosimulation('vvp -m ./myhdl.vpi ./bin/i_buf_controller/i_buf_controller',
                        pclk=pclk, reset_n=reset_n, vsync=vsync,
                        hsync=hsync, vde=vde, i_data=i_data,
                        we=we, addr=addr, o_data=o_data, 
                        line_valid=line_valid, frame_valid=frame_valid)

    return (pclk, reset_n, vsync, hsync, vde, i_data, 
        we, addr, o_data, line_valid, frame_valid, dut)


def test_readout_into_linebuffer():
    """ Test that we can buffer data into a linebuffer.

    """
    capture_data = Image.new('L', (image_data.size[0], 1))
    capture_pixels = capture_data.load()

    (pclk, reset_n, vsync, hsync, vde, i_data, 
        we, addr, o_data, line_valid, frame_valid, dut) = _tb_i_buf_controller()

    def _bench():
        @instance
        def stimulus():
            yield reset_n.posedge

            # Start capturing data into linebuffer
            vde.next = 1
            hsync.next = 1
            for pixel in range(image_data.size[0]):
                i_data.next = image_pixels[pixel, 0]
                yield pclk.posedge


            # Any final bits of data
            vde.next = 0
            yield delay(pclk.period * 5)

            capture_data.save('tests/output/test_readout_into_linebuffer.bmp')

            # Check that test image and captured linebuffer match
            for pixel in range(image_data.size[0]):
                try:
                    assert capture_pixels[pixel, 0] == image_pixels[pixel, 0]
                except AssertionError:
                    print("Pixel mismatch [{}, {}]. Captured {}, should be {}".format(
                          pixel, 0, capture_pixels[pixel, 0], image_pixels[pixel, 0]))
                    raise AssertionError

            raise StopSimulation

        @always(pclk.posedge)
        def check_linebuffer():
            if int(we):
                # 4 pixels per word, so we need to multiply image offset
                offset = int(addr) * 4
                pixels = struct.unpack('4B', struct.pack('>I', int(o_data)))
                for i in range(4):
                    capture_pixels[offset+i, 0] = pixels[i]

        return dut, pclk.gen(), reset_n.pulse(), stimulus, check_linebuffer
        
    Simulation(_bench()).run()


def test_linebuffer_addr_resets_after_new_line():
    """ Test that the linebuffer address is reset after we start a new
    line.

    """
    (pclk, reset_n, vsync, hsync, vde, i_data, 
        we, addr, o_data, line_valid, frame_valid, dut) = _tb_i_buf_controller()

    def _bench():
        @instance
        def stimulus():
            yield reset_n.posedge

            # Start wait some cycles to simulate data being stored
            # in linebuffer.
            hsync.next = 1
            yield delay(pclk.period * 10)
            vde.next = 1
            yield delay(pclk.period * 100)

            # Start a new line
            vde.next = 0
            yield delay(pclk.period * 10)
            hsync.next = 0
            yield delay(pclk.period * 10)
            
            # Check that address is reset after new line
            assert addr == 0x00

            raise StopSimulation

        return dut, pclk.gen(), reset_n.pulse(), stimulus
        
    Simulation(_bench()).run()


def test_linebuffer_ps_interrupts():
    """ Test that the Processing System receives the correct
    interrupts to notify it about new data.

    """
    (pclk, reset_n, vsync, hsync, vde, i_data, 
        we, addr, o_data, line_valid, frame_valid, dut) = _tb_i_buf_controller()

    def _bench():
        @instance
        def stimulus():
            yield reset_n.posedge

            # Start wait some cycles to simulate data being stored
            # in linebuffer.
            hsync.next = 1
            yield delay(pclk.period * 10)
            vde.next = 1
            yield delay(pclk.period * 100)

            # Start a new line
            vde.next = 0
            yield delay(pclk.period * 10)
            hsync.next = 0
            vsync.next = 0
            yield delay(pclk.period * 10)
            vsync.next = 1

            # PS interrupts are checked in check_line_valid() and
            # check_frame_valid() methods.

            raise StopSimulation

        @always(line_valid.posedge)
        def check_line_valid():
            # line_valid should only occur when vde is low
            assert not int(vde)

        @always(frame_valid.posedge)
        def check_frame_valid():
            # frame_valid goes low briefly when vsync occurs
            assert int(vsync)

        return dut, pclk.gen(), reset_n.pulse(), stimulus, check_line_valid, check_frame_valid
        
    Simulation(_bench()).run()
