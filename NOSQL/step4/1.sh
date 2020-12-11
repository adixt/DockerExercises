docker build . --no-cache -t noslqafterbooksimported
docker kill $(docker ps -q)
docker rm $(docker ps -a -q) 
docker run --name noslqafterbooksimportedname -d noslqafterbooksimported 
sleep 10;
docker ps | tee log.log
docker logs noslqafterbooksimportedname | tee -a log.log

grep log.log -e "27017/tcp" | tee test.log
grep log.log -e "inside entrypoint.sh" | tee -a test.log
grep log.log -e "Mongo server is avaiable at (172.17.0.2:27017)" | tee -a test.log

# and here check
docker build ./checker --no-cache | tee checkerlog.log
grep checkerlog.log -e "Ember.js in Action" | tee -a test.log

clear
out=$(cat test.log | wc -l)
if [ "$out" != "4" ]; then
    echo "Expected '4', but your result is '$out'"
    exit 1
else
    echo "Good job :)"
    exit 0
fi