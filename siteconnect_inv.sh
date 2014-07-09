#!/bin/bash
# This script takes a siteConnect requester ID and shows the last update request and response for this channel

echo -e "Finding updates from today and yesterday...\n"

path="cat /usr/local/siteminder/var/log/siteconnect-comms.log"
oldpath="bzcat /usr/local/siteminder/var/log/siteconnect-comms.log.****-**-**.bz2"

updateCount=$($path | grep "siteconnect-$1-inventory" | grep "RESPONSE" | cut -c '01-23')

if [ -z "$updateCount" ]
then
  echo -e "\nThere have been no updates recently\n"
else
  #lastupdate=$(echo $updateCount | cut -c '1-23')
  $path | grep "$lastupdate"
fi

echo -e "Finding updates from before yesterday...\n"

oldUpdateCount=$($oldpath | grep "siteconnect-$1-inventory" | grep "RESPONSE" | cut -c '01-23')

if [ -z "$oldUpdateCount" ]
then
  echo -e "\nThere have been no updates in the last few weeks\n"
else
  oldlastupdate=$(echo $oldUpdateCount | rev | cut -c '-23' | rev )
  oldtoken=$($oldpath | grep "$oldlastupdate" | cut -c '64-103')
  $oldpath | grep "$oldtoken" | grep "oldlastupdate"
fi
