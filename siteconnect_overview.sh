#!/bin/bash
# No input needed, just run this script as is and it will spit out all of the requster IDs that have been sent to us

echo -e "Collecting partners...\n"

today=$(date '+20%y-%m-%d')

access=$(egrep -Ho 'RequestorID ID="(.{1,20})" Type=' /usr/local/siteminder/var/log/siteconnect-access.* | sort -r -t: -k2 | uniq -f 1 | sed 's/siteconnect-access.//' | sed "s/log:Req/$today,Req/" | sed 's/:Req/,Req/' |   sed 's/\/usr\/local\/siteminder\/var\/log\///   ' | sed 's/log.//' | sed 's/" Type=//' | sed 's/RequestorID ID="//')

oldAccess=$(bzegrep -Ho 'RequestorID ID="(.{1,20})" Type=' /usr/local/siteminder/var/log/siteconnect-access.log.****-**-**.bz2 | sort -r -t: -k2 | uniq -f 1 | sed 's/siteconnect-access.//' | sed 's/log:Req/     Today,Req/' | sed 's/:Req/,Req/' |   sed 's/\/usr\/        local\/siteminder\/var\/log\///' | sed 's/log.//' | sed 's/" Type=//' | sed 's/RequestorID ID="//' | sed 's/.bz2//')

comms=$(egrep -Ho 'siteconnect-(.{1,3}).*RESPONSE' /usr/local/siteminder/var/log/siteconnect-comms.* | sort -t: -k2 | uniq | sed "s/siteconnect-comms.log:/$today,/" | sed 's/siteconnect-//' | sed 's/comms.log.//' | sed 's/:siteconnect-/,/' | sed 's/\/usr\/local\/       siteminder\/var\/log\///' | sed -e 's/-inventoryJob-[^>]*- \[RESPONSE//')

oldComms=$(bzegrep -Ho 'siteconnect-(.{1,3}).*RESPONSE' /usr/local/siteminder/var/log/siteconnect-comms.log.****-**-**.bz2 | sort -t: -k2 | uniq | sed 's/siteconnect-comms.log:/today,/' | sed 's/siteconnect-//' | sed 's/comms.log.//' | sed 's/:siteconnect-/,/' | sed    's/.bz2//' | sed 's/\/usr\/local\/siteminder\/var\/log\///' | sed -e 's/-inventoryJob-[^>]*- \[RESPONSE//')

output=$(echo "$access" && echo "$oldAccess" && echo "$comms" && echo "$oldComms")

echo -e "${output}" | sort -r -t\, -k2 | uniq -s 11

# sends output to CSV
csv=$(echo "${output}" | sort -r -t\, -k2 | uniq -s 11)
echo "$csv" | sort -t\, -k2 > siteconnect.csv
