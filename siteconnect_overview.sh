#!/bin/bash
# No input needed, just run this script as is and it will spit out all of the requster IDs that have been sent to us

today=$(date '+20%y-%m-%d')

usage() {
  echo "Usage\n"
  echo "Siteconnect_overview displays the requestorID from partners with recent activity in our system.\n"
  echo "Options:\n"
  echo "-r, displays siteconnect partners with recent activity (usually from today and yesterday)\n"
  echo "-a, displays siteconnect partners with activity in our aged logs (usually longer than two days ago)\n"
}

while getopts "rah" opt; do
  case $opt in
    r)
      echo "Collecting partners who have responded to inventory requests..."

      comms=$(egrep -Ho 'siteconnect-(.{1,3}).*RESPONSE' /usr/local/siteminder/var/log/siteconnect-comms.* | sort -t: -k2 | uniq | sed "s/siteconnect-comms.log:/$today,/" | sed 's/siteconnect-//' | sed 's/comms.log.//' | sed 's/:siteconnect-/,/' | sed 's/\/usr\/local\/siteminder\/var\/log\///' | sed -e 's/-inventoryJob-[^>]*- \[RESPONSE//')

      echo "Collecting partners who have requested reservations...\n"

      access=$(egrep -Ho 'RequestorID ID="(.{1,20})" Type=' /usr/local/siteminder/var/log/siteconnect-access.* | sort -r -t: -k2 | uniq -f 1 | sed 's/siteconnect-access.//' | sed "s/log:Req/$today,Req/" | sed 's/:Req/,Req/' |   sed 's/\/usr\/local\/siteminder\/var\/log\///   ' | sed 's/log.//' | sed 's/" Type=//' | sed 's/RequestorID ID="//')

      echo "Reservations\n=================================\n"
      echo "${access}" | sort -t\, -k2 | uniq -s 11
      echo "\n"

      echo "Inventory\n=================================\n"
      echo "${comms}" | sort -t\, -k2 | uniq -s 11

      echo "\n"
    ;;
    a)
      echo "Collecting partners from aged logs who have requested inventory..."

      oldComms=$(bzegrep -Ho 'siteconnect-(.{1,3}).*RESPONSE' /usr/local/siteminder/var/log/siteconnect-comms.log.****-**-**.bz2 | sort -t: -k2 | uniq | sed 's/siteconnect-comms.log:/today,/' | sed 's/siteconnect-//' | sed 's/comms.log.//' | sed 's/:siteconnect-/,/' | sed 's/.bz2//' | sed 's/\/usr\/local\/siteminder\/var\/log\///' | sed -e 's/-inventoryJob-[^>]*- \[RESPONSE//')

      echo "Collecting partners from aged logs who have requested reservations...\n"

      oldAccess=$(bzegrep -Ho 'RequestorID ID="(.{1,20})" Type=' /usr/local/siteminder/var/log/siteconnect-access.log.****-**-**.bz2 | sort -r -t: -k2 | uniq -f 1 | sed 's/siteconnect-access.//' | sed 's/log:Req/     Today,Req/' | sed 's/:Req/,Req/' | sed 's/\/usr\/local\/siteminder\/var\/log\///' | sed 's/log.//' | sed 's/" Type=//' | sed 's/RequestorID ID="//' | sed 's/.bz2//')

      echo "Reservations\n=================================\n"
      echo "${oldAccess}" | sort -t\, -k2 | uniq -s 11
      echo "\n"

      echo "Inventory\n=================================\n"
      echo "${oldComms}" | sort -t\, -k2 | uniq -s 11
    ;;
    h)
      usage
      exit
    ;;
    ?)
      usage
      exit
    ;;
  esac
done
