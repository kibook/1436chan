#!/bin/sh

cd $(dirname "$0")

. ./params.sh

now=$(date +%s)

data=$(cat "$DATA_DIR/postpass")

echo "$data" | while read no pass date
do
	if test $((now - date)) -lt "$DELETE_TIME"
	then
		echo "$no	$pass	$date"
	fi
done > "$DATA_DIR/postpass"
