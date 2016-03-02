"""A small script to convert binary EDID dumps to text files for 
Vivado memory initialisation.

"""

import sys
import os


def main():
    """Writes the converted data from EDID dump.

    """
    edid_path = sys.argv[1]
    txt_path = os.path.basename(os.path.splitext(edid_path)[0]) + '.txt'

    with open(txt_path, 'w') as txt_file:
        with open(edid_path, 'rb') as edid_file:
            byte = edid_file.read(1)
            while byte != '':
                txt_file.write('{0:08b}\n'.format(ord(byte)))
                byte = edid_file.read(1)
            
if __name__ == '__main__':
    main()
