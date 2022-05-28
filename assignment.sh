#!/bin/bash
if [ $(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install apache2;
fi
timestamp=$(date '+%d%m%Y-%H%M%S')
tarfilename="Himanshu-httpd-logs-$timestamp.tar"
archive=$(find /var/log/apache2 -type f -name "*.log")
tar cvf $tarfilename $archive
archive=$(find /home/ubuntu/Automation_Project/ -type f -name "*.tar")
aws s3 cp $tarfilename s3://upgrad-automation
mv $tarfilename "/var/tmp/"
