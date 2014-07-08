#!/bin/bash
# To run this script enter the Requester ID of the PMS in question. This will then throw out the last inventory update that we received and the how many we have received

path="cat /usr/local/siteminder/var/log/pmsxchangev2-access.*"
oldPath="bzcat /usr/local/siteminder/var/log/pmsxchangev2-access.log.****-**-**.bz2"

updateCount=$($path | grep "RequestorID ID=\"$1" | egrep "HotelAvailNotif|HotelRateAmountNotif" | cut -c '1-23' | sort | uniq)
oldUpdateCount=$($oldPath | grep "RequestorID ID=\"$1" | egrep "HotelAvailNotif|HotelRateAmountNotif" | cut -c '1-23' | sort | uniq)

if [ -z "$updateCount" ]
then
  echo -e "There wass no inventory sent to us by $1 over the last two days\n"
  if [ -z "$oldUpdateCount"]
  then
    echo -e "There was no inventory sent to us by $1 over the last few weeks\n"
  else
    echo -e "The last update that we received for $1 was:\n"
    oldLastUpdate=$(echo $oldUpdateCount | rev | cut -c '-23' | rev)
    oldToken=$($oldPath | grep "$oldLastUpdate" | cut -c '58-69')
    $oldPath | grep $oldToken
  fi
else
  echo -e "The last update that we received for $1 was:\n"
  lastUpdate=$(echo $updateCount | rev | cut -c '-23' | rev)
  token=$($path | grep "$lastUpdate" | cut -c '58-69')
  $path | grep $token

  echo -e "\nThe number of inventory updates received for $1 in the last two days:\n"
  $path | grep "RequestorID ID=\"$1" | egrep "HotelAvailNotif|HotelRateAmountNotif" | sort | uniq | wc -l
  echo -e "\nThe number of inventory updates received for $1 in the last few weeks:\n"
  $oldPath | grep "RequestorID ID=\"$1" | egrep "HotelAvailNotif|HotelRateAmountNotif" | sort | uniq | wc -l

fi
