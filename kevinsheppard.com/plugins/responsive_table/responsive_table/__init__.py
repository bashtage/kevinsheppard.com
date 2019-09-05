# -*- coding: utf-8 -*-
"""Wrap tables in responsive div."""

import glob
import os

from bs4 import BeautifulSoup
from nikola import utils
from nikola.plugin_categories import LateTask


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
