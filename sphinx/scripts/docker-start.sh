#!/bin/sh

export HOST_IP;

HOST_IP=$(ip route show | awk '/default/ {print $3}')

echo "$HOST_IP" > /etc/HOST_IP

if [ -z "$MYSQL_INDEXER_USER" ];
then
    echo "Warning: \$MYSQL_INDEXER_USER not defined!"
    if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ];
    then
        echo "Using '$MYSQL_USER' instead of \$MYSQL_INDEXER_USER";
        MYSQL_INDEXER_USER=$MYSQL_USER
        MYSQL_INDEXER_PASSWORD=$MYSQL_PASSWORD
    elif [ -n "$MYSQL_ROOT_PASSWORD" ];
    then
        echo "Using 'root' instead of \$MYSQL_INDEXER_USER";
        MYSQL_INDEXER_USER=root
        MYSQL_INDEXER_PASSWORD=$MYSQL_ROOT_PASSWORD
    else
        echo "You should have defined a MySQL indexer user in sphinx.conf"
    fi
fi

/etc/sphinx/sphinx.sh > /etc/sphinx/sphinx.conf

sphinx_index.sh
exec sphinx_searchd.sh "$@"
