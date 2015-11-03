from myhdl import *
from uhdl import *
from PIL import Image


image_data = Image.open('tests/images/qcif_test_pattern.bmp').convert('L')
image_pixels = image_data.load()

def _tb_vga_controller():
    # Signals and interfaces etc.
    vga_clk_25 = Clock()
    reset_n = Reset(async=True)
    din = Signal(intbv(0)[8:])
    test_pattern = Signal(0)
    addr = Signal(intbv()[16:])
    vsync = Signal()
    hsync = Signal()
    R = Signal()
    G = Signal()
    B = Signal()

    dut = Cosimulation('vpp -m ./myhdl.vpi ./bin/vga/vga_controller',
                        vga_clk_25=vga_clk_25, reset_n=reset_n, din=din, 
                        test_pattern=test_pattern, addr=addr, vsync=vsync,
                        hsync=hsync, R=R, G=G, B=B)

    return vga_clk_25, reset_n, din, test_pattern, addr, vsync, hsync, R, G, B, dut


def test_vga_output_from_framebuffer():
    """ Test that we can display a frame fetched from the framebuffer.

    """
    vga_clk_25, reset_n, din, test_pattern, addr, vsync, hsync, R, G, B, dut = _tb_vga_controller()
    
    def _bench():

        @instance
        def stimulus():

            raise StopSimulation

        return dut, vga_clk_25.gen(), reset_n.pulse(), stimulus

    Simulation(_bench()).run()


def test_vga_output_from_test_pattern():
    """ Test that we can display a frame from the test pattern
    generator.

    """
    vga_clk_25, reset_n, din, test_pattern, addr, vsync, hsync, R, G, B, dut = _tb_vga_controller()
    
    def _bench():

        @instance
        def stimulus():

            raise StopSimulation

        return dut, vga_clk_25.gen(), reset_n.pulse(), stimulus

    Simulation(_bench()).run()