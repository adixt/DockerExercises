docker build . --no-cache | tee log.log
grep log.log -e greetings\;\) | tee test.log
grep log.log -e Linux | tee -a test.log
clear
out=$(cat test.log | wc -l)
if [ "$out" != "3" ]; then
    echo "Expected '3', but your result is '$out'"
    exit 1
else
    echo "Good job :)"
    exit 0
fi