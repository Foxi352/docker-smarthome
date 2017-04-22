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

## Example container start command
This example starts a version 1.3 container on the default network and maps all essential folders locally to ./files/smarthome/<..>. The hostname of the container will be smarthome.docker. If you map an empty local etc folder it will be populated with example files on startup.

    docker run -d \
        --publish 2424:2424 \
        --volume $PWD/files/smarthome/etc:/usr/local/smarthome/etc \
        --volume $PWD/files/smarthome/items:/usr/local/smarthome/items \
        --volume $PWD/files/smarthome/logics:/usr/local/smarthome/logics \
        --volume $PWD/files/smarthome/scenes:/usr/local/smarthome/scenes \
        --hostname=smarthome.docker \
        --name=shng-smarthome \
        foxi352/smarthome:1.3
