#!/bin/sh

cd $(dirname "$0")

. ./params.sh

if test "$POST_LIMIT" -lt 1
then
	exit
fi

now=$(date +%s)
iphash=$(echo -n "$REMOTE_ADDR" | md5sum | cut -d' ' -f1)

# Remove expired cooldowns
sh updatecooldown.sh $1

cat "$DATA_DIR/${1}cooldown" | while read ip time
do
	if test "$ip" = "$iphash" -a $((now - time)) -lt "$POST_LIMIT"
	then
		exit 1
	fi
done

if test $? != 0
then
	exit 1
fi

echo "$iphash	$(date +%s)" >> "$DATA_DIR/${1}cooldown"
