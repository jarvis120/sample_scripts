#!/bin/bash
#IPcheck script
#17-jan-2017
#created by Jaison
case $1 in
-a|-A)
ipcalc -cs $2
if [ "$?" -eq "0" ];then
{
if [[ $# < 3 ]] ; then echo -e "\nReason not provided. Use -h to check the syntax"
else
{
grep $2 /home/bob/IPlist.txt >/dev/null
if [ "$?" -eq "0" ];then
{
echo -e "\nIP already in the list. Use -c to check"
}
else
{
echo -e "$2 : $3">>/home/bob/IPlist.txt
echo -e "\nIP added in DB"
}
fi
}
fi
}
else
{
echo "The entered IP address is not a valid IPV4 address. Please check the IP address"
}
fi;;
-c|C)
ipcalc -cs $2
if [ "$?" -eq "0" ];then
{
grep -i $2 /home/bob/IPlist.txt >/dev/null
if [ "$?" -eq "0" ];then
{
grep -i $2 /home/bob/IPlist.txt
}
else
{
grep -i `echo $2| cut -d'.' -f 1,2,3` /home/bob/IPlist.txt >/dev/null
if [ "$?" -eq "0" ];then
{
echo -e "\nExact IP address is not there in the DB. Check this range and confirm whether IP address is on the range or not\n"
grep -i `echo $2| cut -d'.' -f 1,2,3` /home/bob/IPlist.txt
}
else
{
echo -e "\nIP address not in our DB of Do Not Block list" 
echo -e "\n*** Please note that the IP address belongs to the organization `whois $2| grep -i OrgName|uniq| awk {'print $2'}` and it belongs to the country `whois $2| grep -i Country|uniq |awk {'print $2'}`Make sure that you check the IP address in iplocation before blocking it."
}
fi
}
fi
}
else
{
echo -e "\nThe entered IP address is not a valid IPV4 address. Please check the IP address"
}
fi
;;
-h)
echo -e "\nUse -c IP.IP.IP.IP to check for an IP address"
echo -e "\nUse -a IP.IP.IP.IP 'Reason for not blocking'(Should use single quotes) for adding an IP address";;
-l)
cat /home/bob/IPlist.txt;;
*)
echo -e "\nwrong argument. Use -h to get the syntax"
;;
esac
