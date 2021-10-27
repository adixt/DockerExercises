docker build . --progress=plain --no-cache -t copypartone | tee buildlog.log
grep buildlog.log -e "This file has a long content." | tee test.log
grep buildlog.log -e "Actually, a really long one." | tee -a test.log
grep buildlog.log -e "rw.*[\w\W]*Hello_Name_In_Docker_Filesystem\.txt" | tee -a test.log
#clear ---> There is no easy way to retrieve build logs in the current Docker version. As a result, TEE is getting an empty input from the pipe.
out=$(cat test.log | wc -l)
if [ "$out" != "3" ]; then
    echo "Expected '3', but your result is '$out'"
    exit 1
else
    echo "Good job :)"
    exit 0
fi