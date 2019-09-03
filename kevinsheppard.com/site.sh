#!/usr/bin/env bash

cp ../bootstrap-material-design/dist/css/*.css themes/kevinsheppard/assets/css/
python generate_index.py
nikola build
python generate_sqaure_thumbnails.py
nikola serve
