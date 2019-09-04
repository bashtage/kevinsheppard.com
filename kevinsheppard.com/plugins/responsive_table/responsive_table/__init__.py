# -*- coding: utf-8 -*-
"""Wrap tables in responsive div."""

import glob
import os

from bs4 import BeautifulSoup
from nikola.plugin_categories import LateTask


class ResponsiveTable(LateTask):
    """Add div to make tables responsive."""

    name = "responsive_table"

    @staticmethod
    def fix_tables(file_name: str):
        with open(file_name) as html:
            soup = BeautifulSoup(html.read())
        tables = soup.findChildren('table', recursive=True)
        for table in tables:
            print('Found a table in ' + file_name)
            table.wraps(soup.new_tag('div', **{'class': 'table-responsive'}))
        with open(file_name, 'w') as html:
            html.write(str(soup))

    def gen_tasks(self):
        """Add div to make tables responsive."""
        kw = {
            "base_url": self.site.config["BASE_URL"],
            "site_url": self.site.config["SITE_URL"],
            "output_folder": self.site.config["OUTPUT_FOLDER"],
            "files_folders": self.site.config['FILES_FOLDERS'],
            "robots_exclusions": self.site.config["ROBOTS_EXCLUSIONS"],
            "filters": self.site.config["FILTERS"],
        }
        html_files = glob.glob(
            os.path.join(kw['output_folder'], '**', '*.html'),
            recursive=True)

        yield self.group_task()
        for html_file in html_files:
            yield {"basename": str(self.name),
                   'name': html_file,
                   'actions': [(self.fix_tables, (html_file,))]}
