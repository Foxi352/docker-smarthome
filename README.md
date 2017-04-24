# SmartHomeNG
For documentation and information on the SmartHomeNG project [check our GitHub page](https://github.com/smarthomeNG/smarthome).

## Exposed ports
* 2424/tcp (websocket for SmartVISU)
* 8383/tcp (for web backend on SmartHomeNG >= 1.3)

## Exported volumes
* /var/www/html (map to your SmartVISU installation)
* /usr/local/smarthome/etc (configuration files)
* /usr/local/smarthome/items (put your item files here)
* /usr/local/smarthome/logics (put your logic files here)
* /usr/local/smarthome/scenes (put your scene files here)

## Example 1: SmartHomeNG only container start command
This example starts a version 1.3 container on the default network and maps all essential folders locally to ./files/smarthome/<..>. The hostname of the container will be smarthome.docker. If you map an empty local etc folder it will be populated with example files on startup.

    docker run -d \
        --publish 8383:8383 \
        --publish 2424:2424 \
        --volume $PWD/files/smarthome/etc:/usr/local/smarthome/etc \
        --volume $PWD/files/smarthome/items:/usr/local/smarthome/items \
        --volume $PWD/files/smarthome/logics:/usr/local/smarthome/logics \
        --volume $PWD/files/smarthome/scenes:/usr/local/smarthome/scenes \
        --hostname=smarthome.docker \
        --name=shng-smarthome \
        foxi352/smarthome:1.3

## Example 2: SmartHomeNG with MariaDB container start command
This example starts a version 1.3 container together with a MariaDB instance, both on the default network. All essential SmartHomeNG folders are mapped locally to ./files/smarthome/<..>. The folder containing the database is mapped to ./files/mariadb. The hostname of the container will be smarthome.docker respectively database.docker. If you map an empty local etc folder it will be populated with example files on startup.

The SmartHomeNG container will in this case wait for the database to be up and running before starting SmartHomeNG. Of course you will need to adapt plugin.yaml in smarthome/etc to match your database settings. See SmartHomeNG Git Wiki for details.

    docker run -d \
        --volume $PWD/files/mariadb:/var/lib/mysql \
        --hostname=database.docker \
        --name=shng-mariadb \
        --env MYSQL_ROOT_PASSWORD=supersecure \
        --env MYSQL_DATABASE=smarthome \
        --env MYSQL_USER=smarthome \
        --env MYSQL_PASSWORD=shngpassword \
        mariadb

	docker run -d \
        --publish 8383:8383 \
        --publish 2424:2424 \
        --volume $PWD/files/smarthome/etc:/usr/local/smarthome/etc \
        --volume $PWD/files/smarthome/items:/usr/local/smarthome/items \
        --volume $PWD/files/smarthome/logics:/usr/local/smarthome/logics \
        --volume $PWD/files/smarthome/scenes:/usr/local/smarthome/scenes \
        --hostname=smarthome.docker \
        --env SHNG_USE_MYSQL=yes
        --env SHNG_MYSQL_HOST=shng-mariadb
        --name=shng-smarthome \
        foxi352/smarthome:1.3
