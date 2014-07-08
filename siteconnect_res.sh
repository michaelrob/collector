#!/bin/bash
# This script takes a siteConnect requester ID and throws out the last reservation request and response
# sent to us by the channel. It then makes a list to show how many they have sent us over the last few weeks.

echo -e "Today and yesterday\n"

path="cat /usr/local/siteminder/var/log/siteconnect-access.*"

last=$($path | grep $1 | cut -c '01-23' | sort | uniq -c)

if [ -z "$last" ]
then
  echo -e "\nThere have been no reservations today\n"

  echo -e "\n============================\n"

  echo -e "Before to today \n"

  oldpath="bzcat /usr/local/siteminder/var/log/siteconnect-access.log.****-**-**.bz2"

  oldlast=$($oldpath | grep $1 | cut -c '01-23' | sort | uniq -c)

  if [ -z "$oldlast" ]
  then
    echo -e "\nThere have been no reservations recently\n"
  else
    oldlastupdate=$(echo $oldlast | rev | cut -c '-23' | rev)
   echo -e  "Last reservation we received for $1 was:\n"
    oldtoken=$($oldpath | grep "$oldlastupdate" | cut -c '58-69')
    $oldpath | grep $oldtoken
  fi

  echo -e "\n"
  echo -e "The number of previous reservations received: \n"
  $oldpath | grep $1 | cut -c '01-23' | sort | uniq -c | wc -l

else
  lastupdate=$(echo $last | rev | cut -c '-23' | rev)
  echo -e  "Last reservation we received for $1 was:\n"
  token=$($path | grep "$lastupdate" | cut -c '58-69')
  $path | grep $token

  echo -e "\n"
  echo -e "The number of previous reservations received today: \n"
  $path | grep $1 | cut -c '01-23' | sort | uniq -c | wc -l
fi
