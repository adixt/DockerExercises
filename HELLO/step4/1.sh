docker build . --no-cache -t cmdvsentrypoint
docker run cmdvsentrypoint | tee log.log
grep log.log -e "hello (from ENTRYPOINT): world (this part is from CMD" | tee test.log
docker run cmdvsentrypoint "FINLAND (overridden parameter)" | tee log.log
grep log.log -e "hello (from ENTRYPOINT): FINLAND (overridden parameter)" | tee test2.log
clear
cat test.log | wc -l
cat test2.log | wc -l
