docker build . --no-cache | tee log.log
grep log.log -e UTC | tee test.log
clear
cat test.log | wc -l