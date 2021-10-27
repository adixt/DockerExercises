# run the nosql server
docker build ./checker --progress=plain --no-cache -t nosqlbasewithbook
docker kill $(docker ps -q)
docker rm $(docker ps -a -q) 
docker run --name nosqlbasewithbookname -d nosqlbasewithbook 
sleep 10;
#

docker build . --progress=plain --no-cache | tee log.log 

grep log.log -e "Ember.js in Action" | tee test.log

#clear ---> There is no easy way to retrieve build logs in the current Docker version. As a result, TEE is getting an empty input from the pipe.
out=$(cat test.log | wc -l)
if [ "$out" != "1" ]; then
    echo "Expected '1', but your result is '$out'"
    exit 1
else
    echo "Good job :)"
    exit 0
fi