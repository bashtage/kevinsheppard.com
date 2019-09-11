#!/usr/bin/env bash

cp ../bootstrap-material-design/dist/css/*.css themes/kevinsheppard/assets/css/
nikola build
nikola serve
