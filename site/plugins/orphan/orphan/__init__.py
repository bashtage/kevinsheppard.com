from nikola.plugin_categories import LateTask
from nikola.utils import LOGGER
import glob
import os
from bs4 import BeautifulSoup
import urllib.parse


class Orphan(LateTask):
    """Find orphan files and broken internal links."""

    name = "orphan"

    def gen_tasks(self):
        self.site.scan_posts()

        kw = {
            "translations": self.site.config["TRANSLATIONS"],
            "output_folder": self.site.config["OUTPUT_FOLDER"],
            "filters": self.site.config["FILTERS"],
            "timeline": self.site.timeline,
        }

        posts = self.site.timeline[:]

        def find_404():
            output = self.site.config["OUTPUT_FOLDER"]
            files = glob.glob(os.path.join(output, "**", "*"), recursive=True)
            files = [os.path.abspath(f) for f in files if not os.path.isdir(f)]
            html_files = [
                f for f in files if f.endswith(".html") and not f.endswith(".src.html")
            ]
            referenced = set()
            link_404 = []
            tags = (("a", "href"), ("img", "src"), ("link", "href"), ("script", "src"))
            skip_start = ("#", "http://", "https://", "mailto:")
            for html_file in html_files:
                base, _ = os.path.split(html_file)
                with open(html_file, "r", encoding="utf-8") as html:
                    soup = BeautifulSoup(html.read(), features="lxml")
                for tag, prop in tags:
                    tag_set = soup.find_all(tag, recursive="True")
                    for node in tag_set:
                        node_prop = node.get(prop, False)
                        if not node_prop or "image/png;base64" in node_prop:
                            continue
                        skip = any([node_prop.startswith(s) for s in skip_start])
                        if skip:
                            continue
                        unquoted = urllib.parse.unquote(node_prop)
                        obj_path = os.path.abspath(os.path.join(base, unquoted))
                        if os.path.isdir(obj_path):
                            obj_path = os.path.join(obj_path, "index.html")
                        missing = os.path.exists(obj_path)
                        referenced.add(obj_path)
                        if not missing:
                            obj_path = obj_path.replace(os.path.abspath(output), "")
                            link_404.append((html_file, obj_path))

            orphans = set(files).difference(referenced)
            skip = ("/index.html", "/search/index.html")
            orphans = [
                o
                for o in orphans
                if not (".thumbnail." in o or o.endswith(".src.html"))
            ]
            warnings = []
            for o in sorted(orphans):
                if os.path.isdir(o):
                    continue
                o = o.replace(os.path.abspath(output), "")
                if o in skip:
                    continue
                warn = any([o.endswith(v) for v in (".html",)])
                if warn:
                    warnings.append(o)
                else:
                    LOGGER.info(f"ORPHAN file: {o}")
            for orphan in warnings:
                LOGGER.warn(f"ORPHAN file (CRUCIAL): {orphan}")
            for html_file, obj_path in link_404:
                LOGGER.error(f"MISSING (404): {html_file}::{obj_path}")

        task = {
            "basename": str(self.name),
            "name": "Find broken internal links",
            "actions": [(find_404, [])],
        }
        yield task
