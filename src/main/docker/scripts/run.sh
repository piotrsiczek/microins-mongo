#!/bin/bash

USER=${USERNAME}
PASS=${PASSWORD}
DB=${DBNAME}

# Start MongoDB service
mkdir -p /data
touch /data/.initdb

# Initialize first run
if [[ -e /data/.initdb ]]; then

	/usr/bin/mongod --dbpath /data --nojournal &
	while ! nc -vz localhost 27017; do sleep 1; done

	# Create User
	echo "Creating user: \"$USER\"..."
	mongo $DB --eval "db.createUser({ user: '$USER', pwd: '$PASS', roles: [ { role: 'dbAdminAnyDatabase', db: '$DB' } ] });"

	# Stop MongoDB service
	/usr/bin/mongod --dbpath /data --shutdown

	rm -f /data/.initdb
fi

# Start MongoDB
echo "Starting MongoDB..."
/usr/bin/mongod --port 27017 --dbpath /data --smallfiles
