docker build . --no-cache -t nosqlcheckercreationep
docker kill $(docker ps -q)
docker rm $(docker ps -a -q) 
docker run --name nosqlcheckercreationepname -d nosqlcheckercreationep 
docker ps | tee log.log
sleep 10;
docker logs nosqlcheckercreationepname | tee -a log.log

grep log.log -e "27017/tcp" | tee test.log
grep log.log -e "MongoDB starting" | tee -a test.log

grep log.log -e "Mongo server is avaiable at (0.0.0.0:27017)" | tee -a test.log
clear
cat test.log | wc -l
