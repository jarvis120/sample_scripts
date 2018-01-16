#!/bin/bash 
#Author: Jayaganesh 

echo "  Script to check entire logs of  a cpanel  user " 
echo 
read -p "Enter username:" username 

echo 
sleep 2s 
echo "checking whether the user exists on cpanel" 
if [ ! "`grep $username /var/cpanel/users/*`" ]; 
then 
echo "$username not found in cpanel" 
else 

echo 
sleep 2s 
echo "Found $username on cpanel" 
echo 
sleep 1s
echo "Checking for cpanel access log  with most POST attemtpted ip address"  
if [ ! "`grep $username /usr/local/cpanel/logs/access_log |grep POST |awk '{print $1}' |sort |uniq -c |sort -n`" ]; 
then 
echo "no cpanel POST attempt for $username" 
else 
sleep 5s 
grep $username /usr/local/cpanel/logs/access_log |grep POST |awk '{print $1}' |sort |uniq -c |sort -n |tail -n 8 
fi 

sleep 5s 
echo 
echo "Checking for password reset attempt in cpanel"  
if [ ! "`grep $username /usr/local/cpanel/logs/access_log |grep -i "passwordstrength.cgi"|awk '{print $1 " " $3}'|sort |uniq -c |sort -n`" ]; 
then 
sleep 2s 
echo "no cpanel passwort reset attempt for $username" 
else 
sleep 5s 
grep $username /usr/local/cpanel/logs/access_log |grep -i "passwordstrength.cgi"|awk '{print $1 " " $3}'|sort |uniq -c |sort -n| tail -n 8 
fi 

sleep 5s 
echo 
echo "Checking for FTP accessed IP address and its notification" 
if [ ! "`grep  $username /var/log/messages* | awk '{print $6,$8,$9}' |sort -n |uniq -c |sort -n|tail -n 7`" ]; 
then 
sleep 2s 
echo "No FTP access for $username" 
else 
sleep 5s 
grep  $username /var/log/messages* | awk '{print $6,$8,$9}' |sort -n |uniq -c |sort -n|tail -n 7 
fi  

sleep 2s 
echo 
echo "checking for ip address that uploaded vai FTP by $username" 
if [ ! "`grep $username /var/log/messages* |grep -iw "uploaded" |awk '{print $6}'|sort |uniq -c |sort -n`" ] ; 
then 
sleep 2s 
echo "no uploads from $username" 
else 
sleep 5s 
grep $username /var/log/messages* |grep -iw "uploaded" |awk '{print $6}'|sort |uniq -c |sort -n  
echo 
read -p "Do you wish to see the uploaded files(y/n) [if yes press q to return to script] " -n 1 -r 
echo    # (optional) move to a new line 
if [[  $REPLY =~ ^[Yy]$ ]]; 
then 
grep $username /var/log/messages* |grep -iw "uploaded"  |awk '{print $1,$2,$6,$8}'|sort |uniq |less 
fi  
fi 

sleep 2s 
echo 
echo "checking for ip address that  Deleted via FTP by $username" 
if [ ! "`grep $username /var/log/messages* |grep -iw "Deleted" |awk '{print $6}'|sort |uniq -c |sort -n`" ] ; 
then 
sleep 2s 
echo "no deleted file from $username" 
else 
sleep 5s 
grep $username /var/log/messages* |grep -iw "Deleted" |awk '{print $6}'|sort |uniq -c |sort -n  
echo 
read -p "Do you wish to see the Deleted  files(y/n) [if yes press q to return to script] " -n 1 -r 
echo    # (optional) move to a new line 
if [[  $REPLY =~ ^[Yy]$ ]]; 
then 
grep $username  /var/log/messages* |grep -iw "Deleted" |awk '{print $1,$2,$6,$8,$9}'|sort|uniq|less 
fi  
fi 

sleep 2s 
echo 
echo "Checking for wp-login and xmlrpc post attempt"  
if [ ! "`fgrep -s -e wp-login -e xmlrpc /usr/local/apache/domlogs/$username/* |grep POST |awk '{print $1 " " $7}' |sort |uniq -c |sort -n`" ]; 
then 
sleep 2s 
echo "no wp-login or xmlrpc post attempt for $username" 
else 
sleep 5s 
fgrep -s -e wp-login -e xmlrpc /usr/local/apache/domlogs/$username/* |grep POST |awk '{print $1 " " $7}' |sort |uniq -c |sort -n|tail -n 10  
fi 

sleep 2s  
echo  
echo "Checking for POST attempts in  dom logs press q when you are done"  
if [ ! "`grep POST /usr/local/apache/domlogs/$username/* `" ];  
then  
sleep 2s 
echo " no domlogs for $username"  
else  
sleep 5s 
grep POST  /usr/local/apache/domlogs/$username/*|less  
fi 

sleep 2s 
echo 
echo "Checking for POST attempt in $username access-logs press q when you are done"  
if [ ! "`grep POST /home/$username/access-logs/* |less`" ]; 
then 
echo "no POST attempt in access log for $username" 
else 
sleep 5s 
grep POST /home/$username/access-logs/* |less  
fi 



sleep 2s 
echo 
echo "Checking for apache access log press q when you are done"  
if [ ! "`grep $username  /usr/local/apache/logs/access_log |less`" ]; 
then 
sleep 2s 
echo "no access_log for $username" 
else 
sleep 5s  
grep $username  /usr/local/apache/logs/access_log |less  
fi 

sleep 2s 
echo 
echo "checking for apache error log press q when you are done" 
if [ ! "`grep $username  /usr/local/apache/logs/error_log |less`" ]; 
then 
sleep 2s 
echo "nothing to show" 
else 
sleep 5s  
grep $username  /usr/local/apache/logs/error_log |less  
fi 


 
sleep 2s 
echo 
echo "Checking for apacher suphp log press q when you are done"  
sleep 2s  
if [ -f /usr/local/apache/logs/suphp_log ]  
then  
sleep 5s 
grep $username /usr/local/apache/logs/suphp_log |less  
else  
sleep 2s 
echo "there is no suphp log"  
fi  

echo 
echo  -e " \e[1m CONGRATS!!!!  YOU HAVE CHECKED ALL THE LOGS \e[1m "  
fi


