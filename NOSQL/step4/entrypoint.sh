echo "inside entrypoint.sh"
/wait-for-mongo.sh & /usr/bin/mongod --bind_ip_all