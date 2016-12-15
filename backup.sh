#!/bin/sh

. ./params.sh

if [ ! -e "backups" ]
then
	mkdir backups
fi

tar zcvf backups/backup_$(date +%s).tar.gz [0-9]* sticky_* motd params.sh 2>/dev/null
