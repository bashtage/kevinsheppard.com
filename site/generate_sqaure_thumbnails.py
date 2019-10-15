import glob
import os
from PIL import Image
import math

THUMBMAX_SIZE = 150

images = glob.glob('./galleries/**/*.jpg', recursive=True)

for image in images:
    base, filename = os.path.split(image)
    out_name = filename[:-3] + 'thumbnail.' + filename[-3:]
    out_name = os.path.abspath(os.path.join('output', base, out_name))
    if os.path.exists(out_name):
        im = Image.open(out_name)
        size = im.size
        if size[0] == size[1] == THUMBMAX_SIZE:
            continue
    print(image)
    im = Image.open(image)
    size = im.size
    thumb_size = math.ceil(max(size) / min(size) * THUMBMAX_SIZE)
    im.thumbnail((thumb_size, thumb_size))
    left = upper = 0
    right, lower = im.size
    if right > THUMBMAX_SIZE:
        excess = right - THUMBMAX_SIZE
        left, right = math.floor(excess / 2.0), math.floor(
            right - excess / 2.0)
    if lower > THUMBMAX_SIZE:
        excess = lower - THUMBMAX_SIZE
        upper, lower = math.floor(excess / 2.0), math.floor(
            lower - excess / 2.0)
    crop = im.crop((left, upper, right, lower))
    crop.save(out_name)
