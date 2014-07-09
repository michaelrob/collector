#!/bin/bash
# To run this script enter the Requester ID of the PMS in question. This will then output the last reservation request that they have sent us and the following response to our reservation XML.
# This also counts the wait time between reservation requests that they are sending to us.

path="cat /usr/local/siteminder/var/log/pmsxchangev2-access.*"
oldPath="bzcat /usr/local/siteminder/var/log/pmsxchangev2-access.log.****-**-**.bz2"

echo -e "Counting update requests...\n"

requestCount=$($path | grep "RequestorID ID=\"$1" | grep "HotelReadRequest" | cut -c '1-23')
oldRequestCount=$($oldPath | grep "RequestorID ID=\"$1" | grep "HotelReadRequest" | cut -c '1-23')

if [ -z "$requestCount" ]
then
  echo -e "There were no reservation requests sent to us by $1 over the last two days\n"
  if [ -z "$oldURequestCount" ]
  then
    echo -e "There were no reservation requests sent to us by $1 over the last few weeks\n"
  else
    echo -e "stuff to come..."
    #echo -e "The last update that we received for $1 was:\n"
    #oldLastUpdate=$(echo $oldUpdateCount | rev | cut -c '-23' | rev)
    #oldToken=$($oldPath | grep "$oldLastUpdate" | cut -c '58-69')
    #$oldPath | grep $oldToken
  fi
else
  echo -e "Today and yesterday $1 sent us \n"
  echo $requestCount | wc -l
  #lastUpdate=$(echo $updateCount | rev | cut -c '-23' | rev)
  #token=$($path | grep "$lastUpdate" | cut -c '58-69')
  #$path | grep $token
fi

#echo -e "\nThe number of inventory updates received for $1 in the last two days:\n"
#$path | grep "RequestorID ID=\"$1" | egrep "HotelAvailNotif|HotelRateAmountNotif" | sort | uniq | wc -l
#echo -e "\nThe number of inventory updates received for $1 in the last few weeks:\n"
#$oldPath | grep "RequestorID ID=\"$1" | egrep "HotelAvailNotif|HotelRateAmountNotif" | sort | uniq | wc -l
