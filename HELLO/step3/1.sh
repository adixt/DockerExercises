docker build . --no-cache -t givemetime 
docker run givemetime | tee log.log
grep log.log -e UTC | tee test.log
clear
cat test.log | wc -l