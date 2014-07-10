#!/bin/bash
# No input needed, just run this script as is and it will spit out all of the requster IDs that have been sent to us

usage() {
  echo "Usage\n"
  echo "Pmsxchange_overview displays the requestorID from partners with recent activity in our system.\n"
  echo "Options:\n"
  echo "-r, displays siteconnect partners with recent activity (usually from today and yesterday)\n"
  echo "-a, displays siteconnect partners with activity in our aged logs (usually longer than two days ago)\n"
}

today=$(date '+20%y-%m-%d')

while getopts "rah" opt; do
  case $opt in
    r)
      echo "Collecting recent PMS partners...\n"

      recent=$(egrep -Ho 'RequestorID ID="(.{1,20})" Type=' /usr/local/siteminder/var/log/pmsxchangev2-access.* | sort -r -t: -k2 | uniq -f 1 | sed 's/pmsxchangev2-access.//' | sed -e "s/log:Req/$today,Req/" | sed 's/:Req/,Req/' | sed 's/\/usr\/local\/siteminder\/var\/log\///' | sed 's/log.//' | sed 's/" Type=//' | sed 's/RequestorID ID="//')

      echo "${recent}" | sort -t\, -k2 | uniq -s 11

      echo "\n"
    ;;
    a)
      echo "Collecting aged PMS partners...\n"

      aged=$(bzegrep -Ho 'RequestorID ID="(.{1,20})" Type=' /usr/local/siteminder/var/log/pmsxchangev2-access.log.****-**-**.bz2 | sort -r -t: -k2 | uniq -f 1 | sed 's/pmsxchangev2-access.//' | sed 's/log:Req/Today,Req/' | sed 's/:Req/,Req/' | sed 's/\/usr\/local\/siteminder\/var\/log\///' | sed 's/log.//' | sed 's/" Type=//' | sed 's/RequestorID ID="//' | sed 's/.bz2//')

      echo "${aged}" | sort -t\, -k2 | uniq -s 11
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
