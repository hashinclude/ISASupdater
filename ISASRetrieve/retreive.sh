#!/bin/bash
read -p "Enter Email ID to send update   :" email
read -p 'Enter User Name   :' uname
stty -echo
read -p 'Enter password    :' passw
stty echo
echo
rm old new
rm tmp615243*
touch new
while ((1))
do
echo "RUNNING!!"
export https_proxy=""
export http_proxy=""
export ftp_proxy=""
wget  -q --save-cookies=cookies.txt --keep-session-cookies --no-check-certificate --post-data "StUdent=$uname&searchin=200&password=$passw&submit=Submit" "https://isas.iiit.ac.in/validate.php" -O tmp615243
mv new old
wget  -q  --load-cookies=cookies.txt --keep-session-cookies --no-check-certificate "https://isas.iiit.ac.in/academicProfile.php" -O new
sleep 1

grep -q Login new
if [ $? -eq "0" ]
then
	echo "WRONG PASSWORD"
	break
fi
diff -q old new
if [ $? -eq "1" ]
then
	export https_proxy="http://proxy.iiit.ac.in:8080"
	export http_proxy="http://proxy.iiit.ac.in:8080"
	export ftp_proxy="http://proxy.iiit.ac.in:8080"
	python conv.py > msg12345
	echo "UPDATED!!! SENDING EMAIL!!!!!!!"
	echo
	(echo "EHLO" 
	sleep 1
	echo "MAIL FROM: <iiit@web.iiit.ac.in>" 
	sleep 1
	echo "RCPT TO: <$email>" 
	sleep 1
	echo "DATA"
	echo
	echo -e "
	Subject: Updated
	"
	cat msg12345
	echo
	echo "."
	sleep 1
	echo "QUIT" 
	sleep 1
	)|telnet gmail-smtp-in.l.google.com 25
else
	echo "NO CHANGE"
	export https_proxy=""
	export http_proxy=""
	export ftp_proxy=""
fi
rm tmp615243*
sleep 10
done
