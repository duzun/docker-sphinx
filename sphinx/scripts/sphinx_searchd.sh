#!/bin/sh

exec searchd -c /etc/sphinx/sphinx.sh --nodetach "$@"
