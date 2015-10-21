""" Quick test to see what using a 3-bit colour palette looks like. 

"""

from PIL import Image

palette = (
    (0,     0,      0),
    (0,     0,      255),
    (0,     255,    0),
    (0,     255,    255),
    (255,   0,      0),
    (255,   0,      255),
    (255,   255,    0),
    (255,   255,    255)
)

if __name__ == '__main__':

    img1 = Image.open('images/cat.jpg').convert('LA')
    img2 = Image.new('RGB', img1.size)
    for x in range(img1.size[0]):
        for y in range(img1.size[1]):
            val = img1.getpixel((x, y))[0]
            img2.putpixel((x, y), palette[val >> 5])

    img2.show()
