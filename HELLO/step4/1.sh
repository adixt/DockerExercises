docker build . --progress=plain --no-cache -t cmdvsentrypoint
docker run cmdvsentrypoint | tee log.log
grep log.log -e "hello (from ENTRYPOINT): world (this part is from CMD" | tee test.log
docker run cmdvsentrypoint "FINLAND (overridden parameter)" | tee log.log
grep log.log -e "hello (from ENTRYPOINT): FINLAND (overridden parameter)" | tee test2.log
#clear ---> There is no easy way to retrieve build logs in the current Docker version. As a result, TEE is getting an empty input from the pipe.

out=$(cat test.log | wc -l)
out2=$(cat test2.log | wc -l)
out3=$out+$out2
if [ "$out3" != "1+1" ]; then
    echo "Expected '1+1', but your result is '$out3'"
    exit 1
else
    echo "Good job :)"
    exit 0
fi
