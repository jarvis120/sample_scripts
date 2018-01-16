#!bin/bash 
echo "This is to check network statistics of port 80,21,22,25,143,110" 
echo 

echo "The high connection to port 80  aka HTTPD are" 
netstat -natp | grep :80| awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n | tail -n 7 

echo "The high connection to port 21  aka FTP are" 
netstat -natp | grep :21| awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n | tail -n 7 

echo "The high connection to port 22  aka SSH are" 
netstat -natp | grep :22| awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n | tail -n 7 

echo "The high connection to port 25  aka SMTP are" 
netstat -natp | grep :25| awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n | tail -n 7 

echo "The high connection to port 143  aka IMAP are" 
netstat -natp | grep :143| awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n | tail -n 7 

echo "The high connection to port 110  aka POP3  are" 
netstat -natp | grep :110| awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n | tail -n 7

