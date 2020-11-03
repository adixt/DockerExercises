docker build . --no-cache | tee log.log
grep log.log -e greetings | tee test.log