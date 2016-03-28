"""A small script to convert image files (anything supported by PIL)
into C header for memory initialisation.

"""

import sys
import os

from PIL import Image


def main():
    """Writes the C header with converted data from the image.

    """
    img_path = sys.argv[1]
    header_path = os.path.splitext(img_path)[0] + '.h'

    with open(header_path, 'w') as header_file:
        header_file.write('#include "xil_types.h"\n#include "platform_config.h"\n\n')
        header_file.write("u8 test_pattern[FRAMEBUF_HEIGHT][FRAMEBUF_WIDTH] = {\n")

        # Data
        img_data = Image.open(img_path).convert('L')
        img_pixels = img_data.load()
        for y in range(img_data.size[1]):
            header_file.write('\t{')
            for x in range(img_data.size[0]):
                header_file.write("\t0x{}".format(format(img_pixels[x, y], 'x')))
                if x < img_data.size[0] - 1:
                    header_file.write(',')
            if y < img_data.size[1] - 1:
                header_file.write('\t},\n')
            else:
                header_file.write('\t}\n')


        # Termination
        header_file.write('};\n')


if __name__ == '__main__':
    main()
