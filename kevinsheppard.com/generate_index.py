import glob
import math
import os
from collections import namedtuple

from PIL import Image
from jinja2 import Template

THUMBMAX_SIZE = 300

dir_names = []
dirs = glob.glob('./galleries/*')
thumbnails = {}
for d in dirs:
    name = os.path.split(d)[-1]
    file = sorted(glob.glob(d + '/*'))[0]
    out_name = name + '-' + file.split(os.path.sep)[-1]
    out_name = os.path.join('images', out_name)
    dir_names.append((name, out_name))
    if os.path.exists(out_name):
        im = Image.open(out_name)
        size = im.size
        if size[0] <= THUMBMAX_SIZE and size[1] <= THUMBMAX_SIZE:
            continue
        else:
            print(name, size)

    im = Image.open(file)
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


dir_names = sorted(dir_names,
                   key=lambda x: x[0].split('(')[-1].split(')')[0],
                   reverse=True)

gallery = namedtuple('gallery', ['url', 'name', 'thumbnail'])

galleries = []
for name, out_name in dir_names:
    g = gallery(url='/galleries/' + name + '/index.html',
                name=name.replace('-', ' '),
                thumbnail='/' + out_name)
    galleries.append(g)

with open('generated_index.tmpl', 'r') as tmpl:
    template = Template(tmpl.read())

with open('./pages/photos.html', 'w') as index:
    index.write(template.render(galleries=galleries))
