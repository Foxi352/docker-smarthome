#!/bin/sh

ARGS=$@
SHNG_PATH=/usr/local/smarthome
EXAMPLES_PATH=/usr/local/examples

# If MySQL is enabled wait for it to be up and our database to be ready 
if [ ! -z "$SHNG_USE_MYSQL" ]; then
	echo "Waiting for MySQL database '$MYSQL_DATABASE' on host '$SHNG_MYSQL_HOST'"
	./check_for_mysql.py --host=$SHNG_MYSQL_HOST --database=$MYSQL_DATABASE --user=$MYSQL_USER --password=$MYSQL_PASSWORD
	while [ $? -ne 0 ] ; do
	   echo -n .
	   sleep 1
	   ./check_for_mysql.py --host=$SHNG_MYSQL_HOST --database=$MYSQL_DATABASE --user=$MYSQL_USER --password=$MYSQL_PASSWORD
	done
fi

# Check if there is a minimum of config files, if not provide some example to prevent startup errors
if [ ! -e "$SHNG_PATH/etc/smarthome.conf" ]; then 
    cp $EXAMPLES_PATH/etc/smarthome.conf $SHNG_PATH/etc/smarthome.conf; 
fi
if [ ! -e "$SHNG_PATH/etc/logging.yaml" ]; then 
    cp $EXAMPLES_PATH/etc/logging.yaml $SHNG_PATH/etc/logging.yaml; 
fi
if [ ! -e "$SHNG_PATH/etc/logics.conf" ]; then 
    cp $EXAMPLES_PATH/etc/logics.conf $SHNG_PATH/etc/logics.conf; 
fi
if [ ! -e "$SHNG_PATH/etc/plugin.conf" ]; then 
    cp $EXAMPLES_PATH/etc/plugin.conf $SHNG_PATH/etc/plugin.conf; 
fi

# Launch our main service, preferably in debug mode as it should stay in foreground
$SHNG_PATH/bin/smarthome.py "$ARGS"

