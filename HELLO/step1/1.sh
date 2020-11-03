docker build . --no-cache | tee log.log
grep log.log -e greetings\;\) | tee test.log
grep log.log -e Linux | tee -a test.log
clear
cat test.log | wc -l