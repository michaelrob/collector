#!/bin/bash
# To run this script enter the Requester ID of the PMS in question. This will then output the last reservation request that they have sent us and the following response to our reservation XML.
# This also counts the wait time between reservation requests that they are sending to us.

path="cat /usr/local/siteminder/var/log/pmsxchangev2-access.*"
oldPath="bzcat /usr/local/siteminder/var/log/pmsxchangev2-access.log.****-**-**.bz2"

echo -e "Counting update requests for $1...\n"

requesterUsername=$($path | grep "RequestorID ID=\"$1" | grep "HotelReadRequest" | egrep -o "Username>(.{1,20})<" | sed 's/Username>//' | sed 's/<//'
requestCount=$($path | grep "RequestorID ID=\"$1" | grep "HotelReadRequest" | cut -c '1-23' | wc -l)
reservationResponse=$($path | grep "Username>" | grep "HotelNotifReport")

echo -e "Today and yesterday $1 sent us ${requestCount} reservation requests\n"
