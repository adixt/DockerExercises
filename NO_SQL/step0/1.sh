docker build . --no-cache -t nosqlone
docker kill $(docker ps -q)
docker rm $(docker ps -a -q) 
docker run --name nosqlonename -d nosqlone 
sleep 10;
docker ps | tee log.log
docker logs nosqlonename | tee -a log.log

grep log.log -e "27017/tcp" | tee test.log
grep log.log -e "MongoDB starting" | tee -a test.log
grep log.log -e "\"address\":\"127.0.0.1\"" | tee -a test.log
clear
cat test.log | wc -l
