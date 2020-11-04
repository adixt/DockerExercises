docker build . --no-cache -t nosqlchecker
docker kill $(docker ps -q)
docker rm $(docker ps -a -q) 
docker run --name nosqlcheckername -d nosqlchecker 
docker ps | tee log.log
sleep 10;
docker logs nosqlcheckername | tee -a log.log

grep log.log -e "27017/tcp" | tee test.log
grep log.log -e "MongoDB starting" | tee -a test.log

grep log.log -e "Mongo server is avaiable at (0.0.0.0:27017)" | tee -a test.log
clear
cat test.log | wc -l
