docker build . --no-cache -t nosqlwithcheck
docker kill $(docker ps -q)
docker rm $(docker ps -a -q) 
docker run --name nosqlwithcheckname -d nosqlwithcheck 
docker ps | tee log.log
docker logs nosqlwithcheckname | tee -a log.log

grep log.log -e "27017/tcp" | tee test.log
grep log.log -e "MongoDB starting" | tee -a test.log

# and here check
docker build ./checker --no-cache -t checkerone
docker run checkerone | tee checkerlog.log

grep checkerlog.log -e "Mongo server is avaiable at (172.17.0.2:27017)" | tee -a test.log
clear
out=$(cat test.log | wc -l)
if [ "$out" != "2" ]; then
    echo "Expected '2', but your result is '$out'"
    exit 1
else
    echo "Good job :)"
    exit 0
fi
