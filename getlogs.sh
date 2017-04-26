#!/bin/sh

# Go through all servers and retrieve the logs

L="log_"`date +"%Y%m%d_%H%M"`

mkdir $L

echo "Downloading log files to ${L}."

for h in `./fivemservers.py `
do
  echo -n '.'
  (wget --timeout=4 --tries=2 -qO ${L}/${h}.log $h/log ; /bin/echo -ne '\b \b' ) &
  sleep 0.15
done

wait

echo "Cleaning up empty logs."

find ./${L}/. -size 0 -exec rm {} \;

echo "Done..."

