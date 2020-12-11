docker build . --no-cache -t givemetime 
docker run givemetime | tee log.log
grep log.log -e UTC | tee test.log
clear
out=$(cat test.log | wc -l)
if [ "$out" != "1" ]; then
    echo "Expected '1', but your result is '$out'"
    exit 1
else
    echo "Good job :)"
    exit 0
fi