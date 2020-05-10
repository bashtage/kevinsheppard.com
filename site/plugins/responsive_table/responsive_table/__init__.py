# -*- coding: utf-8 -*-
"""Wrap tables in responsive div."""

import glob
import math
import os

from PIL import Image
from bs4 import BeautifulSoup
from nikola import utils
from nikola.plugin_categories import LateTask


class ResponsiveTable(LateTask):
    """Add div to make tables responsive."""

    name = "responsive_table"

    def fix_tables(self):
        html_files = glob.glob(
            os.path.join(self.kw["output_folder"], "**", "*.html"), recursive=True
        )
        for file_name in html_files:
            with open(file_name, encoding="utf8") as html:
                soup = BeautifulSoup(html.read(), features="lxml")
            tables = soup.findChildren("table", recursive=True)
            first = True
            for table in tables:
                if (
                    table.parent.name == "div"
                    and "class" in table.parent.attrs
                    and table.parent.attrs["class"] == ["table-responsive"]
                ):
                    continue
                if first:
                    utils.LOGGER.info("Fixing tables in " + file_name)
                    first = False
                div_responsive = soup.new_tag("div", **{"class": "table-responsive"})
                table.wrap(div_responsive)
            for elem in ("th", "td"):
                table_elements = soup.findChildren(elem, recursive=True)
                for te in table_elements:
                    if "align" in te.attrs:
                        alignment = [f"text-{te.attrs['align']}"]
                        if "class" in te:
                            te["class"] += alignment
                        else:
                            te["class"] = alignment
                        del te["align"]

            with open(file_name, "w", encoding="utf8") as html:
                html.write(str(soup))

    def square_thumbnails(self):
        THUMBNAIL_SIZE = self.site.config["THUMBNAIL_SIZE"]
        path = os.path.join(
            self.kw["output_folder"], "galleries", "**", "*.thumbnail.*"
        )
        thumbs = glob.glob(path, recursive=True)
        for thumb in thumbs:
            output = thumb
            base, ext = os.path.splitext(thumb)
            if ext == ".svg":
                continue
            im = Image.open(thumb)
            size = im.size
            if size[0] == size[1] == THUMBNAIL_SIZE:
                continue
            thumb = base[:-10] + ext
            im = Image.open(thumb)
            size = im.size
            thumb_size = int(math.ceil(max(size) / min(size) * THUMBNAIL_SIZE))
            im.thumbnail((thumb_size, thumb_size))
            left = upper = 0
            right, lower = im.size
            if right > THUMBNAIL_SIZE:
                excess = right - THUMBNAIL_SIZE
                left = math.floor(excess / 2.0)
                right = math.floor(right - excess / 2.0)
            if lower > THUMBNAIL_SIZE:
                excess = lower - THUMBNAIL_SIZE
                upper = math.floor(excess / 2.0)
                lower = math.floor(lower - excess / 2.0)
            crop = im.crop((left, upper, right, lower))
            utils.LOGGER.info(
                "Resized " + thumb + " from " + str(size) + " to " + str(crop.size)
            )
            crop.save(output)

    def gen_tasks(self):
        """Add div to make tables responsive."""
        self.kw = {
            "base_url": self.site.config["BASE_URL"],
            "site_url": self.site.config["SITE_URL"],
            "output_folder": self.site.config["OUTPUT_FOLDER"],
            "files_folders": self.site.config["FILES_FOLDERS"],
            "robots_exclusions": self.site.config["ROBOTS_EXCLUSIONS"],
            "filters": self.site.config["FILTERS"],
        }

        yield self.group_task()
        yield {
            "basename": str(self.name),
            "name": "Make tables responsive",
            "actions": [self.fix_tables],
        }
        yield {
            "basename": str(self.name),
            "name": "Make thumbnails square",
            "actions": [self.square_thumbnails],
        }
