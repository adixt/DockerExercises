docker build . --no-cache -t aplinepart2  | tee buildlog.log
grep buildlog.log -e "rw.*[\w\W]*entrypoint.sh" | tee test.log
grep buildlog.log -e "rw.*[\w\W]*hello.txt" | tee -a test.log
docker run aplinepart2 | tee log.log
grep log.log -e ">>>>> inside entrypoint.sh >>>>>" | tee -a test.log
grep log.log -e "This file has a long content." | tee -a test.log
grep log.log -e "Actually, a really long one." | tee -a test.log
grep log.log -e ">>>>> end of entrypoint.sh >>>>>" | tee -a test.log
clear
out=$(cat test.log | wc -l)
if [ "$out" != "6" ]; then
    echo "Expected '6', but your result is '$out'"
    exit 1
else
    echo "Good job :)"
    exit 0
fi