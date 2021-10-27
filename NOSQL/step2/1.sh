docker build . --progress=plain --no-cache -t nosqlchecker
docker kill $(docker ps -q)
docker rm $(docker ps -a -q) 
docker run --name nosqlcheckername -d nosqlchecker 
docker ps | tee log.log
sleep 10;
docker logs nosqlcheckername | tee -a log.log

grep log.log -e "27017/tcp" | tee test.log
grep log.log -e "MongoDB starting" | tee -a test.log

grep log.log -e "Mongo server is avaiable at (0.0.0.0:27017)" | tee -a test.log
#clear ---> There is no easy way to retrieve build logs in the current Docker version. As a result, TEE is getting an empty input from the pipe.
out=$(cat test.log | wc -l)
if [ "$out" != "2" ]; then
    echo "Expected '2', but your result is '$out'"
    exit 1
else
    echo "Good job :)"
    exit 0
fi
