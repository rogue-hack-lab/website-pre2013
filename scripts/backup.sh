#!/bin/bash
# for backing up the mediawiki
# copied from http://www.mediawiki.org/wiki/User:Flominator/Backup_MW
# install in /var/lib/mediawiki
FNAME=`date +%Y-%m-%d`
mysqldump --database wikidb -u root -pthisisntthepassword  --add-drop-table -B > ${FNAME}.sql
zip -r ./backup/${FNAME}.zip images/ ${FNAME}.sql LocalSettings.php extensions/
rm ${FNAME}.sql
