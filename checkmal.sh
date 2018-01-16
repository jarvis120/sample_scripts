#!bin/bash 
echo "Enter the username" 
read name 
echo "The username you entered is" $name 

echo "finding whether there are any new_malicious_code"; 
echo "************" 
find /home/$name/public_html -type f -exec grep -irlF "\$_COOKIE [str_replace('.', '_', \$_SERVER['HTTP_HOST'])]" {} \; 
echo "*************" 
echo 
echo "finding whether there are any base64 malicious code and favicon"; 
echo "-----------" 
find /home/$name/public_html -type f -exec grep -Rl '"base" . "64_decode";return' {} \; 
echo "-----------" 
echo "" 
echo "searching for new GLOBALS malicious files" 

echo "+++++++" 
grep -rl '$GLOBALS\[$GLOBALS' --include=*.php /home/$name/public_html 
echo "+++++++" 
echo 

echo "searching for code injected files please remove single line code in here" 
echo "##########" 
grep -irl "x2fh" --include=*.php /home/$name/public_html 
echo "##########" 

echo 
echo "finding shell files if any" 
echo "==========" 
grep '((eval.*(base64_decode|gzinflate|\$_))|\$[0O]{4,}|FilesMan|JGF1dGhfc|IIIl|die\(PHP_OS|posix_getpwuid|"base" . "64_decode";return|Array\(ba
se64_decode|document\.write\("\\u00|sh(3(ll|11)))' . -lroE --include=*.php*|grep -v class-wp-filesystem-ssh2.php|grep -v class-wp-filesystem-direct.php 
echo "==========" 
echo "" 

echo "searching for php and html file which are executable" 
echo "********" 
find /home/$name/public_html  -type f \( -iname '*.php' -o -iname '*.html' \) -perm 755 
echo "********" 
echo 

echo "searching for the" $name "datbase" 

grep -irl "DB_NAME" --include=wp-config.php "/home/$name" 

echo "searching for the malicious user wp.service.controller in the database" 
grep -irl "wp.service.controller" /var/lib/mysql/"$name"_*/*_users.*


