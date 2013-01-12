#!/bin/bash

# trac-wiki
test ! -f trac-wiki.el \
    && wget https://raw.github.com/tiborsimko/trac-wiki-el/master/trac-wiki.el
