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
    image.

    """
    img_path = sys.argv[1]
    coe_path = os.path.basename(os.path.splitext(img_path)[0]) + '.coe'

    with open(coe_path, 'w') as coe_file:
        # Header
        coe_file.write("memory_initialization_radix=16;\n")
        coe_file.write("memory_initialization_vector=\n")

        # Data
        img_data = Image.open(img_path)
        img_pixels = img_data.load()
        for y in range(img_data.size[1]):
            for x in range(img_data.size[0]):
                coe_file.write(format(img_pixels[x, y], 'x'))
                if x < img_data.size[0] - 1 or y < img_data.size[1] - 1:
                    coe_file.write(',\n')


        # Termination
        coe_file.write(';')


if __name__ == '__main__':
    main()
