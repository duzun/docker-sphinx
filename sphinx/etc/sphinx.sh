#!/bin/sh

# Dynamic sphinx.conf
# @author Dumitru Uzun (DUzun.Me)

_dir=$(dirname "$0")

[ -z "$HOST_IP" ] && \
HOST_IP=$(ip route show | awk '/default/ {print $3}')

SPHINX_PATH=/var/lib/sphinx
SPHINX_DATA_PATH=$SPHINX_PATH/data
SPHINX_LOGS_PATH=$SPHINX_PATH/log

sedesc() {
    echo "$@" | sed -e 's/[\/&]/\\&/g';
}

_sed="s/\$HOST_IP/$HOST_IP/g; s/\$MYSQL_INDEXER_USER/${MYSQL_INDEXER_USER:-25}/g; s/\$MYSQL_INDEXER_PASSWORD/$MYSQL_INDEXER_PASSWORD/g; s/\$MYSQL_ROOT_PASSWORD/$MYSQL_ROOT_PASSWORD/g;"
_sed="$_sed s/\$SPHINX_PATH/$(sedesc $SPHINX_PATH)/g;"
_sed="$_sed s/\$SPHINX_DATA_PATH/$(sedesc $SPHINX_DATA_PATH)/g;"
_sed="$_sed s/\$SPHINX_LOGS_PATH/$(sedesc $SPHINX_LOGS_PATH)/g;"

load() {
    _r="$_sed"
    [ -n "$DB" ] && _r="$_r s/\$DB/$(sedesc "$DB")/g;"
    echo "";
    sed "$_r" "$1"
}

load "$_dir/mysql.part.conf"

for i in "$_dir/conf.d/"*.conf; do
    DB=$(basename "$i" .conf)
    DB=${DB#[0-9]*_}
    _v=$(echo "DATABASE_$DB" | tr "[:lower:]-" "[:upper:]_")
    eval "DB=\${$_v:-$DB}"
    [ "$DB" = "-" ] || load "$i"
done
DB=

load "$_dir/searchd.part.conf"

_sed=
_dir=
