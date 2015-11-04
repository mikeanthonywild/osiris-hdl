from myhdl import *
from uhdl import *
from PIL import Image


image_data = Image.open('tests/images/qcif_test_pattern.bmp').convert('L')
image_pixels = image_data.load()

def _tb_vga_controller():
    # Signals and interfaces etc.
    vga_clk_25 = Clock()
    reset_n = Reset()
    din = Signal(intbv(0)[8:])
    test_pattern = Signal(0)
    addr = Signal(intbv()[16:])
    vsync = Signal(0)
    hsync = Signal(0)
    R = Signal(0)
    G = Signal(0)
    B = Signal(0)

    dut = Cosimulation('vvp -m ./myhdl.vpi ./bin/vga/vga_controller',
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
            yield delay(vga_clk_25.period * 800 * 530)
            assert False
            raise StopSimulation

        @always(vga_clk_25.posedge)
        def framebuffer_read():
            x = int(addr) % image_data.size[0]
            y = int(addr) / image_data.size[0]
            try:
                #din.next = image_pixels[x, y]
                din.next = addr[8:]
            except IndexError:
                pass

        return dut, vga_clk_25.gen(), reset_n.pulse(), stimulus, framebuffer_read

    Simulation(_bench()).run()


'''
def test_vga_output_from_test_pattern():
    """ Test that we can display a frame from the test pattern
    generator.

    """
    capture_data = Image.new('RGB', (640, 480))
    capture_pixels = capture_data.load()

    vga_clk_25, reset_n, din, test_pattern, addr, vsync, hsync, R, G, B, dut = _tb_vga_controller()
    
    def _bench():

        @instance
        def stimulus():
            #test_pattern.next = 1
            yield delay(vga_clk_25.period * 800 * 550)

            assert False
            raise StopSimulation

        @always(vga_clk_25.posedge)
        def framebuffer_read():
            din.next = addr[8:]

        @always(vga_clk_25.posedge)
        def check_framebuffer():
            #count = count + 1
            #test_var = test_var + 1
            try:
                x = int(addr) % capture_data.size[0]
                y = int(addr) / capture_data.size[0]
                capture_pixels[x, y] = (int(R), int(G), int(B))
            except IndexError:
                pass

        return dut, vga_clk_25.gen(), reset_n.pulse(), stimulus, check_framebuffer, framebuffer_read

    Simulation(_bench()).run()
'''