# -*- coding: utf-8 -*-
"""Wrap tables in responsive div."""

import glob
import os

from bs4 import BeautifulSoup
from nikola import utils
from nikola.plugin_categories import LateTask
from PIL import Image
import math

class ResponsiveTable(LateTask):
    """Add div to make tables responsive."""

    name = "responsive_table"

    def fix_tables(self):
        html_files = glob.glob(
            os.path.join(self.kw['output_folder'], '**', '*.html'),
            recursive=True)
        for file_name in html_files:
            with open(file_name) as html:
                soup = BeautifulSoup(html.read(), features='lxml')
            tables = soup.findChildren('table', recursive=True)
            for table in tables:
                utils.LOGGER.info('Found a table in ' + file_name)
                if (table.parent.name == 'div'
                        and 'class' in table.parent.attrs
                        and table.parent.attrs['class'] == ['table-responsive']):
                    utils.LOGGER.info('Skipping table!!!')
                    continue
                table.wrap(
                    soup.new_tag('div', **{'class': 'table-responsive'}))
            with open(file_name, 'w') as html:
                html.write(str(soup))

    def square_thumbnails(self):
        path = os.path.join(self.kw['output_folder'],
                            'galleries','**', '*.thumbnail.*')
        thumbs = glob.glob(path, recursive=True)
        for thumb in thumbs:
            if thumb.endswith('.svg'):
                continue
            im = Image.open(thumb)
            size = im.size
            if size[0] == size[1]:
                continue
            THUMBMAX_SIZE = min(size)
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
            utils.LOGGER.info('Resized ' + thumb)
            crop.save(thumb)

    def gen_tasks(self):
        """Add div to make tables responsive."""
        self.kw = {
            "base_url": self.site.config["BASE_URL"],
            "site_url": self.site.config["SITE_URL"],
            "output_folder": self.site.config["OUTPUT_FOLDER"],
            "files_folders": self.site.config['FILES_FOLDERS'],
            "robots_exclusions": self.site.config["ROBOTS_EXCLUSIONS"],
            "filters": self.site.config["FILTERS"],
        }

        yield self.group_task()
        yield {"basename": str(self.name),
               'name': 'Make tables responsive',
               'actions': [self.fix_tables]}
        yield {"basename": str(self.name),
               'name': 'Make thumbnails square',
               'actions': [self.square_thumbnails]}