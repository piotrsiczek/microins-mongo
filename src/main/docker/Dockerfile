FROM ubuntu

################## BEGIN INSTALLATION ######################

# Import the public key used by the package management system
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6

# Create a list file for MongoDB
RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list

# Reload local package database
RUN apt-get update

# Install the MongoDB packages
RUN apt-get install -y mongodb-org

# Create the default data directory

##################### INSTALLATION END #####################

# Expose the default port
EXPOSE 27017

ADD scripts /scripts
RUN chmod +x /scripts/*.sh

ENTRYPOINT ["/scripts/run.sh"]

VOLUME ["/data"]

# Start MongoDB
#echo "Starting MongoDB..."
#/usr/bin/mongod --dbpath /data --auth $@
