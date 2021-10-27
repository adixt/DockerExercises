docker build . --progress=plain --no-cache -t createfilewithalpine  | tee buildlog.log
grep buildlog.log -e "rw.*[\w\W]*1.txt" | tee test.log
docker run createfilewithalpine | tee log.log
grep log.log -e "greetings from the file" | tee -a test.log
#clear ---> There is no easy way to retrieve build logs in the current Docker version. As a result, TEE is getting an empty input from the pipe.
out=$(cat test.log | wc -l)
if [ "$out" != "2" ]; then
    echo "Expected '2', but your result is '$out'"
    exit 1
else
    echo "Good job :)"
    exit 0
fi
