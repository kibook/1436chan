#!/bin/sh

cd $(dirname "$0")

. ./params.sh

now=$(date +%s)

data=$(cat "$DATA_DIR/${1}cooldown")

echo "$data" | while read ip time
do
	if test $((now - time)) -lt "$POST_LIMIT"
	then
		echo "$ip	$time"
	fi
done > "$DATA_DIR/${1}cooldown"
