#!/bin/bash  
#Author:Jayaganesh 
#script to check olddomains with its dir size if exists 

echo "This is a script to check olddomain with its dir size if exists" 
sleep 1 

#checking for old domains 
echo 
echo "the old domains are "  
echo "----------"  
grep "^old" /etc/trueuserdomains 
echo "-----------" 


#cuting the old string from the domain to check further its A record  
after_cut=$(grep "^old" /etc/trueuserdomains |cut -d: -f1|sed 's/old-//'|sed 's/old//'|sed 's/old.//'); 
echo 
echo "the domains after cutting the string old is "; 
echo "========="  
printf "%s\n" $after_cut; 
echo "========="  

#checking currently where the domains are resolving 
echo 
echo "the domains are now resolving to "; 
echo "*********"  
for i in $after_cut;do  host -t A $i;done 
echo "*********"  



#echo "saving the username to /tmp/olddomain.txt for future reference" 
echo 
echo "saving the username of the old domain to /tmp/olddomain.txt" 
grep "^old" /etc/trueuserdomains |awk '{print $2}' > /tmp/olddomain.txt 


#check whether directory exist  
echo 
echo "checking the size of the directory if it exists" 
while IFS= read -r i;  

      do  
              if [ ! -d /home/$i ];  
                      then  
                              2>&1  
                              echo "no direcotry named /home/$i present"  
                      else  
                               echo " the directory /home/$i exist and its size is " 
                              du -sch /home/$i|grep -v total  
              fi  
done < /tmp/olddomain.txt


