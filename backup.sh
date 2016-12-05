cd "${0%/*}"

tar zcvf backups/backup_`date +%s`.tar.gz * --exclude='*.tar.gz'
