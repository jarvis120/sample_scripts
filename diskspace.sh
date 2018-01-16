#!/bin/bash  
#Author: Jayaganesh  

#This is a script to find disk space usage  

echo "This script is used to check disk sapce usage"  

echo  
echo "The current disk space is "  
echo "====================="  
df -h /  
echo "====================="  
sleep 1  
#checking for tar files  
echo  
echo "checking for tar and gz  files under home folder which is greater than 499M"  
find /home/ -maxdepth 3 -type f   \( -iname "*.tar.gz" -o -iname "*.tar" \) > /tmp/listtar.txt 
if [ ! -s /tmp/listtar.txt ];  
then  
echo "no tar or gz  files greater than 500M"  
else  
echo "the result is saved in /tmp/listtar.txt for future reference"  
sleep 1  
#displaying the tar files with its size  
echo  
echo "the tar files with its size greater than 500Mb  are"  
echo  
echo "-------------------------------------------------"  
while IFS= read -r i;  do du -sch "$i"|grep -e [5-9][0-9][0-9]M -e [0-9]G -e [0-9]T|grep -v total;done <  /tmp/listtar.txt  
echo "-------------------------------------------------"  
sleep 1  
fi  

#checking for public_html_bak folder  
echo  
echo "checking for public_html_* files more than 500MB"  
sleep 1  
find /home/* -maxdepth 2  -type d  -iname "public_html[-.]*" >/tmp/listbak.txt  
if [ ! -s /tmp/listbak.txt ];  
then  
echo "there are no files greater than 500M "  
else  
echo "the result is saved in /tmp/listbak.txt for future reference"  
sleep 1  
#displaying the bak files with its size  
echo  
echo "the public_html_* files with its size are"  
echo  
echo "*******************************"  
while IFS= read -r i; do du -sch "$i"|grep -e [5-9][0-9][0-9]M -e [0-9]G|grep -v total;done < /tmp/listbak.txt  
echo "********************************"  
fi  


#checking for log files under cpanel user home  directory  
echo  
echo "checking for different type of log files under cpanel user home direcotry"  
find /home/*/public_html/ -maxdepth 2 -type f -iname "*[-._]log" > /tmp/listlog.txt  
if [ ! -s /tmp/listlog.txt ];  
then  
echo "no log files are there"  
else  
echo "the entire log result is saved in /tmp/listlog.txt for future refrence "  
sleep 1  
#display the log files greater than 499 mb  
echo  
echo "the   log files of users [error_log] wich are greater than 500mb are"  
echo "++++++++++++++++++"  
while IFS= read -r i; do du -sch "$i"|grep -e [5-9][0-9][0-9]M -e [0-9]G -e [0-9]T|grep -v total;done < /tmp/listlog.txt  
echo "++++++++++++++++++"  
fi  

#checking the size of the cpanel logs  
echo  
echo "the entire size of the cpanel logs from the location /usr/local/cpanel/logs is"  
sleep 2  
du -sch  /usr/local/cpanel/logs/  |grep -w total   


#checking for the size of apache logs  
echo  
echo "the entire size of the apache logs from the location /usr/local/apache/logs is"  
sleep 2  
du -sch /usr/local/apache/logs/ |grep -w total  

#checking for the size of /var/log direcotry  
echo  
echo "the entire size of the directory /var/log is"  
sleep 2  
du -sch /var/log/  |grep -w total  
echo  
echo "If the cpanel,apache or /var/log is more than 5GB size and if you need to check the size including hidden directories just go to the directory and give the command du -sch .[^.]* * |grep -e [5-9][0-9][0-9]M -e [0-9]G -e [0-9]T"
