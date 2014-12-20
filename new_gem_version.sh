#!/bin/bash

librarian-chef install
rm -f madscience-*.gem
gem build madscience.gemspec
gem push madscience-*.gem
