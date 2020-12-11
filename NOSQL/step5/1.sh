# run the nosql server
docker build ./checker --no-cache -t nosqlbasewithbook
docker kill $(docker ps -q)
docker rm $(docker ps -a -q) 
docker run --name nosqlbasewithbookname -d nosqlbasewithbook 
sleep 10;
#

docker build . --no-cache | tee log.log 

grep log.log -e "Ember.js in Action" | tee test.log

clear
out=$(cat test.log | wc -l)
if [ "$out" != "1" ]; then
    echo "Expected '1', but your result is '$out'"
    exit 1
else
    echo "Good job :)"
    exit 0
fi