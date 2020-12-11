docker build . --no-cache -t copyvsaddadvanced | tee buildlog.log
grep buildlog.log -e " total 16"| tee test.log
grep buildlog.log -e "rw.*[\w\W]*hello1"| tee -a test.log
grep buildlog.log -e "rw.*[\w\W]*hello2"| tee -a test.log
grep buildlog.log -e "This file has been created by the magic of the ADD docker command."| tee -a test.log
grep buildlog.log -e "This file has been created by following steps"| tee -a test.log
grep buildlog.log -e "1) manual copy .tar.gz"| tee -a test.log
grep buildlog.log -e "2) extract the archive"| tee -a test.log
grep buildlog.log -e "3) remove the archies"| tee -a test.log
clear
out=$(cat test.log | wc -l)
if [ "$out" != "6" ]; then
    echo "Expected '6', but your result is '$out'"
    exit 1
else
    echo "Good job :)"
    exit 0
fi