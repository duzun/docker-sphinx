Docker Sphinx
==========

Sphinx Search for Docker.

# Install and setup

```sh
sudo docker run -d -i -p "9312:9312" \
        -v /etc/sphinx/conf.d:/etc/sphinx/conf.d \
        -v /run/sphinx/:/run/sphinx/ \
        -v /run/mysqld/:/run/mysqld/ \
     --name 'sphinx' duzun/docker-sphinx
```

In `/etc/sphinx/conf.d` you could place some sphinx config files, one per database.
The name of the files in this folder should be '00_dbName.conf'.
You can override DB name with environment variables like 'DATABASE_DBNAME=my_db'.
In '00_dbName.conf' file you could use the `$DB` variable like this:
`sql_db = $DB`. See `/sphinx/etc/conf.d/*.conf.dist` for more examples.

You could also expose `/run/sphinx/searchd.sock` to host system to connect to sphinx daemon 
through a socket.

It is also possible to use MySQL as a source of documents through sockets by exposing 
`/run/mysqld/` folder to container.

This container defines a volume at `/var/lib/sphinx`, with `data` and `log` folders.


Also check `docker-composer.yml` file for an example of usage.
