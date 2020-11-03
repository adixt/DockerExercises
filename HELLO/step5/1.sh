docker build . --no-cache -t copypartone | tee buildlog.log
grep buildlog.log -e "This file has a long content." | tee test.log
grep buildlog.log -e "Actually, a really long one." | tee -a test.log
grep buildlog.log -e "rw.*[\w\W]*Hello_Name_In_Docker_Filesystem\.txt" | tee -a test.log
clear
cat test.log | wc -l
