#!/bin/sh

_rotate=

pidof searchd > /dev/null && _rotate=--rotate

exec indexer -c /etc/sphinx/sphinx.sh --all $_rotate
