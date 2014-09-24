#!/bin/bash

librarian-chef install
rm madscience-*.gem
gem build madscience.gemspec
gem push madscience-*.gem
