#!/bin/sh

: ${MONGO_HOST:=172.17.0.2}
: ${MONGO_PORT:=27017}

echo "Waiting for Mongo ($MONGO_HOST:$MONGO_PORT) to start..."
index=0
shouldBreak=false
until nc -z $MONGO_HOST $MONGO_PORT || $shouldBreak = true
do
    echo "Waiting for Mongo ($MONGO_HOST:$MONGO_PORT) to start..."
    sleep 0.5
    index=$((index+1))
    if [ $index = 20 ];
    then
        shouldBreak=true
    fi
done

if [ $shouldBreak = true ]
then
    echo "Mongo server NOT FOUND at ($MONGO_HOST:$MONGO_PORT)."
else
    echo "Mongo server is avaiable at ($MONGO_HOST:$MONGO_PORT)."
fi

# now the MongoDB server is operative.
# import the books.json into the database
mongoimport -d myDatabase -c books --file books.json
