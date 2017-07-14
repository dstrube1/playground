 #! /bin/bash

###################################################################
#This script does the daily backups. 
#
#First it makes sure the mount exists: 
# if not, die. 
#
#Then it deletes any backup after 1 month, 
# unless it's at the beginning of the month,
# in which case we copy it to another directory for longer storage
# and manual deletion later, maybe. 
#
#Then, we do the backups.
#
# This file lives here: 10/50.1.77:/etc/cron.daily/backup.sh
###################################################################

#1: if the mount not exists, die

$FOUND = false

for MOUNT in `mount`
do
  if [ -a $MOUNT ]
  then
#    echo "something exists: "$MOUNT
    if [ -b $MOUNT ]
    then
#      echo "mount exists: "$MOUNT
      if [ $MOUNT == "/media/grail" ]
      then
        echo "my mount exists: grail"
        $FOUND = true
      fi
    fi
  fi
done

if ($FOUND)
then
  echo "Found mount."
else
  echo "Didn't find the mount. Dying now."
  exit 0
fi

#for each [wiki, timesheet, cvs]:
#2: if exists backup 1 month old, then
if [ -a "/home/grail/"`date +%Y-%m-%d -d"1 month ago"` ]
then
  echo "backup exists: "`date +%Y-%m-%d -d"1 month ago"`
#	if today is the first day of the month, copy old backup to somewhere else
#	either way, delete it
  if [ `date +%d` == "01" ]
  then #call it mbu, for monthly backup
    cp --archive "/home/grail/"`date +%Y-%m-%d -d"1 month ago"` "/home/grail/mbu_"`date +%Y-%m-%d -d"1 month ago"`
  fi
  rm -rf "/home/grail/"`date +%Y-%m-%d -d"1 month ago"`
fi

#3: copy backup from grail to here, named after time
mkdir "/home/grail/"`date +%Y-%m-%d`
cp --archive /media/grail/gforge_backup.sql.gz "/home/grail/"`date +%Y-%m-%d`"/."
cp --archive /media/grail/timesheet_dump.txt.gz "/home/grail/"`date +%Y-%m-%d`"/."
cp --archive /media/grail/Wiki.tar.gz "/home/grail/"`date +%Y-%m-%d`"/."

