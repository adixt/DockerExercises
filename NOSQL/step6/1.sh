docker kill $(docker ps -q)
docker rm $(docker ps -a -q) 
docker-compose up -d --build
sleep 10;

docker ps | tee log.log 

grep log.log -e "->27017/tcp" | tee test.log
grep log.log -e "dockerfile-sweet-image:" | tee -a test.log

#clear ---> There is no easy way to retrieve build logs in the current Docker version. As a result, TEE is getting an empty input from the pipe.
out=$(cat test.log | wc -l)
if [ "$out" != "4" ]; then
    echo "Expected '4', but your result is '$out'"
    exit 1
else
    echo "Good job :)"
    exit 0
fi