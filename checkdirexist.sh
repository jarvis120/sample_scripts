#!/bin/bash 

#check whether directory exist 
while IFS= read -r i; 

       do 
               if [ ! -d /home/$i ]; 
                       then 
                               2>&1 
                               echo "no direcotry named /home/$i present" 
                       else 
                               du -sch /home/$i|grep -w total 
               fi 
done < /home/jayaganeshr/a.txt 
