"""A small script to convert image files (anything supported by PIL)
into CoreGen COE files for memory initialisation.

Based on COE file specification:
http://www.xilinx.com/support/documentation/sw_manuals/xilinx11/cgn_r_coe_file_syntax.htm

"""

import sys
import os

from PIL import Image


def main():
    """Writes the COE file header and the converted data from the
    image. Special version for 32-bit word size.

    """
    img_path = sys.argv[1]
    coe_path = os.path.splitext(img_path)[0] + '.coe'

    with open(coe_path, 'w') as coe_file:
        # Header
        coe_file.write("memory_initialization_radix=16;\n")
        coe_file.write("memory_initialization_vector=\n")

        # Data
        img_data = Image.open(img_path)
        img_pixels = img_data.load()
        for offset in range(0, img_data.size[0], 4):
            pixels = 0
            for i in range(4):
                pixels = pixels | img_pixels[offset+i, 0] << ((3-i) * 8)
                
            coe_file.write(format(pixels, 'x'))
            if offset < img_data.size[0] - 4:
                coe_file.write(',\n')


        # Termination
        coe_file.write(';')


if __name__ == '__main__':
    main()
