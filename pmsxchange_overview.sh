#!/bin/bash
# No input needed, just run this script as is and it will spit out all of the requster IDs that have been sent to us

echo -e "Collecting partners...\n"

today=$(date '+20%y-%m-%d')

results=$(egrep -Ho 'RequestorID ID="(.{1,20})" Type=' /usr/local/siteminder/var/log/pmsxchangev2-access.* | sort -r -t: -k2 | uniq -f 1 | sed 's/pmsxchangev2-access.//' | sed -e "s/log:Req/$today,Req/" | sed 's/:Req/,Req/' |   sed 's/\/usr\/local\/siteminder\/var\/    log\///' | sed 's/log.//' | sed 's/" Type=//' | sed 's/RequestorID ID="//')

oldResults=$(bzegrep -Ho 'RequestorID ID="(.{1,20})" Type=' /usr/local/siteminder/var/log/pmsxchangev2-access.log.****-**-**.bz2 | sort -r -t: -k2 | uniq -f 1 | sed 's/pmsxchangev2-access.//' | sed     's/log:Req/     Today,Req/   ' | sed 's/:Req/,Req/' |   sed 's/\/   usr\/local\/siteminder\/var\/log\///' | sed 's/log.//' | sed 's/" Type=//' | sed 's/RequestorID ID="//' | sed 's/.bz2//')

output=$(echo "$results" && echo "$oldResults")

echo -e "${output}" | sort -r -t\, -k2 | uniq -s 11

# sends output to CSV
csv=$(echo "${output}" | sort -r -t\, -k2 | uniq -s 11)
echo "$csv" | sort -t\, -k2 > pmsxchange.csv
