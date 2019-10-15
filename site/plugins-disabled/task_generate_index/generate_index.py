"""Generate an index using the galleries in /galleries"""

from nikola.plugin_categories import Task
from nikola import utils


class GenerateIndex(Task):
    """Generate a robots.txt file."""

    name = "generate_index"

    def gen_tasks(self):
        """Generate a an index file."""
        yield tuple([])
