#!/bin/bash
# No input needed, just run this script as is and it will spit out all of the requster IDs that have been sent to us

today=$(date '+20%y-%m-%d')

results=$(egrep -Ho 'RequestorID ID="(.{1,20})" Type=' /usr/local/siteminder/var/log/pmsxchangev2-access.* | sort -r -t: -k2 | uniq -f 1 | sed 's/pmsxchangev2-access.//' | sed -e "s/log:Req/$today,Req/" | sed 's/:Req/,Req/' |   sed 's/\/usr\/local\/siteminder\/var\/    log\///' | sed 's/log.//' | sed 's/" Type=//' | sed 's/RequestorID ID="//')

oldResults=$(bzegrep -Ho 'RequestorID ID="(.{1,20})" Type=' /usr/local/siteminder/var/log/pmsxchangev2-access.log.****-**-**.bz2 | sort -r -t: -k2 | uniq -f 1 | sed 's/pmsxchangev2-access.//' | sed     's/log:Req/     Today,Req/   ' | sed 's/:Req/,Req/' |   sed 's/\/   usr\/local\/siteminder\/var\/log\///' | sed 's/log.//' | sed 's/" Type=//' | sed 's/RequestorID ID="//' | sed 's/.bz2//')

output=$(echo "$results" && echo "$oldResults")

csv=$(echo "${output}" | sort -r -t\, -k2 | uniq -s 11)
echo "$csv" | sort -t\, -k2 > pmsxchange.csv

# curl -L --silent --request PUT --header "Authorization: GoogleLogin auth=DQAAAPsAAAAWB4f8y3FiuuuVYJm94ezVx5G4u4nQwEOcyQaZ8lh4wvC2-DpFSuFqn5RebGkOhqBiLF6Ch77sIrldSQWLK7jVu9iOBH7ulPJkaQxwplHX-kpX7gVqph5IzZZ-msHvF1z-s2WtcuZ7od2kL77Au_fJBtyUjj_6f4jxIiqZDUS5y-sZIQgBfQWaeW4tcoEw2cIcj7SfW74MP1CUhDcXhpNEI78-UBGsOGDM59Zcug53Tm3gvDls3NSTIq3lib4IYQcC-NNp7nfKmyCHGwb9ub-CjiRWZ_-4c0dHv8YXXYDZ7mSjYLlSCwDRbbpB_TSXQCkGw31vnLKo0K8oYEnD_hXC" --header "Slug: pmsxchange overview" --header "Content-Type: text/csv" --data-binary "@pmsxchange.csv" "https://docs.google.com/feeds/media/private/full/spreadsheet%3A0Ati03AydCatmdHlLXzF0MXNab2t1WTlCVDVseG5DS1E/hlhhqpnu"
# google linking no longer used
