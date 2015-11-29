from myhdl import *
from uhdl import *
from PIL import Image


image_data = Image.open('tests/images/qvga_test_pattern.bmp').convert('L')
image_pixels = image_data.load()

def _tb_vga_controller():
    # Signals and interfaces etc.
    vga_clk_25 = Clock()
    reset_n = Reset()
    din = Signal(intbv(0)[8:])
    test_pattern = Signal(0)
    addr = Signal(intbv(0)[17:])
    vsync = Signal(0)
    hsync = Signal(0)
    R = Signal(intbv(0)[3:])
    G = Signal(intbv(0)[3:])
    B = Signal(intbv(0)[2:])

    dut = Cosimulation('vvp -m ./myhdl.vpi ./bin/vga/vga_controller',
                        vga_clk_25=vga_clk_25, reset_n=reset_n, din=din, 
                        test_pattern=test_pattern, addr=addr, vsync=vsync,
                        hsync=hsync, R=R, G=G, B=B)

    return vga_clk_25, reset_n, din, test_pattern, addr, vsync, hsync, R, G, B, dut


def test_vga_output_from_framebuffer():
    """ Test that we can display a frame fetched from the framebuffer.

    """
    capture_data = Image.new('L', (640, 480))
    capture_pixels = capture_data.load()

    vga_clk_25, reset_n, din, test_pattern, addr, vsync, hsync, R, G, B, dut = _tb_vga_controller()
    
    def _bench():
        @instance
        def stimulus():
            yield reset_n.posedge

            # Wait a clock period to latch first address in to RAM
            yield vga_clk_25.posedge

            for line in range(525):
                for col in range(800):
                    if col < 640 and line < 480:
                        capture_pixels[col, line] = int(R)
                    yield vga_clk_25.posedge

            capture_data.save('tests/output/test_vga_output_from_framebuffer.bmp')

            # Check captured data
            for line in range(480):
                for col in range(640):
                    if col < image_data.size[0] and line < image_data.size[1]:
                        expected_pixel = image_pixels[col, line] >> 5
                    else:
                        expected_pixel = 0

                    try:
                        # Output is grayscale, so just check R channel
                        assert capture_pixels[col, line] == expected_pixel
                    except AssertionError:
                        print("Pixel mismatch [{}, {}]. Captured {}, should be {}".format(
                              col, line, capture_pixels[col, line], expected_pixel))
                        raise AssertionError
            raise StopSimulation

        @always(vga_clk_25.posedge)
        def framebuffer_read():
            x = int(addr) % image_data.size[0]
            y = int(addr) / image_data.size[0]
            try:
                din.next = image_pixels[x, y] >> 5
            except IndexError:
                pass
                #print("Index error [{}, {}]".format(x, y))
                #raise IndexError

        return dut, vga_clk_25.gen(), reset_n.pulse(), stimulus, framebuffer_read

    Simulation(_bench()).run()


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
            test_pattern.next = 1
            yield reset_n.posedge
            
            # Wait a clock period to latch first address in to RAM
            yield vga_clk_25.posedge

            for line in range(525):
                for col in range(800):
                    if col < 640 and line < 480:
                        capture_pixels[col, line] = (R, G, B)
                    yield vga_clk_25.posedge

            capture_data.save('tests/output/test_vga_output_from_test_pattern.bmp')

            # Check captured data
            for line in range(480):
                for col in range(640):
                    try:
                        # Output is grayscale, so just check R channel
                        expected_pixel = ((line % 2) * 255) >> 5
                        assert capture_pixels[col, line][0] == expected_pixel
                    except AssertionError:
                        print("Pixel mismatch [{}, {}]. Captured {}, should be {}".format(
                              col, line, capture_pixels[col, line], expected_pixel))
                        raise AssertionError

            raise StopSimulation

        return dut, vga_clk_25.gen(), reset_n.pulse(), stimulus

    Simulation(_bench()).run()


def test_vga_output_rgb_coherence():
    """ Test that R, G and B outputs are equal.

    """
    vga_clk_25, reset_n, din, test_pattern, addr, vsync, hsync, R, G, B, dut = _tb_vga_controller()
    
    def _bench():

        @instance
        def stimulus():
            din.next = 0xff >> 5
            yield reset_n.posedge
            
            # Wait a clock period to latch first address in to RAM
            yield vga_clk_25.posedge

            try:
                assert R == G and (G >> 1) == B
            except AssertionError:
                print("Pixel coherence mismatch. Captured [{}, {}, {}], should be [{}, {}, {}]".format(
                      R, G, B, R, R, R >> 1))
                raise AssertionError

            raise StopSimulation

        return dut, vga_clk_25.gen(), reset_n.pulse(), stimulus

    Simulation(_bench()).run()